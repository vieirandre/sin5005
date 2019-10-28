class Fundo < ApplicationRecord
  validates_presence_of :ticker

  require 'httparty'
  require 'nokogiri'

  def self.scrap(ticker)
    url = "https://www.fundsexplorer.com.br/funds/#{ticker}/"
    pagina = HTTParty.get(url)

    return unless pagina.success?

    pagina_parseada = Nokogiri::HTML(pagina)
    fundo = extrai_fundo(ticker, pagina_parseada)
    salva(fundo)
  end

  def self.popula
    @url_main = 'https://www.fundsexplorer.com.br/funds/'
    @url_alt = 'https://fiis.com.br/lista-por-codigo/'

    pagina = HTTParty.get(@url = @url_main)
    pagina = HTTParty.get(@url = @url_alt) unless pagina.success?

    pagina_parseada = Nokogiri::HTML(pagina)
    tickers = extrai_tickers(pagina_parseada)

    tickers.each do |ticker|
      scrap(ticker) if Fundo.find_by_ticker(ticker).nil?
    end
  end

  private

  def self.extrai_tickers(pagina_parseada)
    tickers = []

    case @url
    when @url_main
      pagina_parseada.css('span.symbol').each do |fundo|
        ticker = fundo.children[0].text.strip.upcase
        tickers.push(ticker)
      end
    when @url_alt
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
    end
  end

  def self.salva(fundo)
    fundo.save!
  end
end