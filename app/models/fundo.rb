class Fundo < ApplicationRecord
  validates_presence_of :ticker

  require 'httparty'
  require 'nokogiri'

  def self.scrap(ticker)
    @url_fundo_main = "https://www.fundsexplorer.com.br/funds/#{ticker}/"
    @url_fundo_alt = "https://fiis.com.br/#{ticker}/?aba=geral"

    pagina = captura_pagina
    return unless pagina.success?

    pagina_parseada = Nokogiri::HTML(pagina)
    fundo = extrai_fundo(ticker, pagina_parseada)
    salva(fundo)
  end

  def self.popula
    @url_tickers_main = 'https://www.fundsexplorer.com.br/funds/'
    @url_tickers_alt = 'https://fiis.com.br/lista-por-codigo/'

    pagina = HTTParty.get(@url_tickers = @url_tickers_main)
    pagina = HTTParty.get(@url_tickers = @url_tickers_alt) unless pagina.success?

    return unless pagina.success?

    pagina_parseada = Nokogiri::HTML(pagina)
    tickers = extrai_tickers(pagina_parseada)

    tickers.each do |ticker|
      scrap(ticker) if Fundo.find_by_ticker(ticker).nil?
    end
  end

  private

  def self.captura_pagina
    case @url_tickers
    when nil?
      pagina = HTTParty.get(@url_fundo = @url_fundo_main)
      pagina = HTTParty.get(@url_fundo = @url_fundo_alt) unless pagina.success?
    when @url_tickers_main
      pagina = HTTParty.get(@url_fundo = @url_fundo_main)
    when @url_tickers_alt
      pagina = HTTParty.get(@url_fundo = @url_fundo_alt)
    end

    pagina
  end

  def self.extrai_tickers(pagina_parseada)
    tickers = []

    case @url_tickers
    when @url_tickers_main
      pagina_parseada.css('span.symbol').each do |fundo|
        ticker = fundo.children[0].text.strip.upcase
        tickers.push(ticker)
      end
    when @url_tickers_alt
      tabela = pagina_parseada.search('table').first
      qtde = tabela.css('tr > td').count / 3 - 1
      base = 3

      qtde.times do
        ticker = tabela.css('tr > td')[base].text.partition('*').first.strip.upcase
        base += 3
        tickers.push(ticker)
      end
    end

    tickers
  end

  def self.extrai_fundo(ticker, pagina_parseada)
    case @url_fundo
    when @url_fundo_main
      extrai_fundo_main(ticker, pagina_parseada)
    when @url_fundo_alt
      extrai_fundo_alt(ticker, pagina_parseada)
    end
  end

  def self.extrai_fundo_main(ticker, pagina_parseada)
    Fundo.new do |f|
      f.ticker = ticker
      f.preco = pagina_parseada.css('span.price')[0].text.delete('R$').strip
      f.nome = pagina_parseada.css('h2.section-subtitle')[0].text
      f.cnpj = pagina_parseada.css('span.description')[8].text.strip
      f.segmento = pagina_parseada.css('span.description')[11].text.strip
      f.tx_adm = pagina_parseada.css('span.description')[13].text.strip.delete('^0-9.').chomp('.')
      f.data_const = pagina_parseada.css('span.description')[1].text.strip
      f.num_cotas_emitidas = pagina_parseada.css('span.description')[2].text.strip
      f.patrimonio_inicial = pagina_parseada.css('span.description')[3].text.delete('R$').strip
      f.valor_inicial_cota = pagina_parseada.css('span.description')[4].text.delete('R$').strip
      f.prazo = pagina_parseada.css('span.description')[12].text.strip
      f.tipo_gestao = pagina_parseada.css('span.description')[5].text.strip
    rescue StandardError
      nil
    end
  end

  def self.extrai_fundo_alt(ticker, pagina_parseada)
    Fundo.new do |f|
      f.ticker = ticker
      f.nome = pagina_parseada.css('h2.entry-title')[0].text.split('–').last.strip
      f.cnpj = pagina_parseada.css('td')[1].text.strip
      f.segmento = pagina_parseada.css('td')[7].text.strip
      f.data_const = pagina_parseada.css('td')[15].text.strip
      f.num_cotas_emitidas = pagina_parseada.css('td')[21].text.chomp('*').strip
      f.tipo_gestao = pagina_parseada.css('td')[5].text.split(' ').last.strip
    rescue StandardError
      nil
    end
  end

  def self.salva(fundo)
    fundo.save!
  end
end