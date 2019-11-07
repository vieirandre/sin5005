class Fundo < ApplicationRecord
  validates_presence_of :ticker

  require 'httparty'
  require 'nokogiri'

  def self.scrap(ticker)
    @url_fundo_main = "https://www.fundsexplorer.com.br/funds/#{ticker}/"
    @url_fundo_alt = "https://fiis.com.br/#{ticker}/"

    pagina = HTTParty.get(@url_fundo = @url_fundo_main)
    pagina = HTTParty.get(@url_fundo = @url_fundo_alt) unless pagina.success?

    return unless pagina.success?

    pagina_parseada = Nokogiri::HTML(pagina)
    fundo = extrai_fundo(ticker, pagina_parseada)
    salva(fundo)
  end

  def self.popula
    @url_tickers_main = 'https://www.fundsexplorer.com.br/funds/'
    @url_tickers_alt = 'https://fiis.com.br/lista-de-fundos-imobiliarios/'

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

  def self.extrai_tickers(pagina_parseada)
    tickers = []

    case @url_tickers
    when @url_tickers_alt
      extrai_tickers_alt(pagina_parseada, tickers)
    else
      extrai_tickers_main(pagina_parseada, tickers)
    end

    tickers
  end

  def self.extrai_tickers_main(pagina_parseada, tickers)
    pagina_parseada.css('span.symbol').each do |fundo|
      ticker = fundo.children[0].text.strip.upcase
      tickers.push(ticker)
    end
  end

  def self.extrai_tickers_alt(pagina_parseada, tickers)
    lista_fundos = pagina_parseada.css('span.ticker')

    lista_fundos.each do |fundo|
      tickers.push(fundo.text)
    end
  end

  def self.extrai_fundo(ticker, pagina_parseada)
    case @url_fundo
    when @url_fundo_alt
      extrai_fundo_alt(ticker, pagina_parseada)
    else
      extrai_fundo_main(ticker, pagina_parseada)
    end
  end

  def self.extrai_fundo_main(ticker, pagina_parseada)
    Fundo.new do |f|
      f.ticker = ticker
      f.preco = pagina_parseada.css('span.price')[0].text.delete('R$').strip
      f.nome = pagina_parseada.css('h2.section-subtitle')[0].text
      f.cnpj = pagina_parseada.css('span.description')[8].text.strip
      f.segmento = pagina_parseada.css('span.description')[11].text.strip
      f.tx_adm = extrai_taxa_adm(ticker)
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
      f.preco = pagina_parseada.css('div.item.quotation').css('span.value').text
      f.nome = pagina_parseada.at_css('span#fund-name').text
      f.cnpj = pagina_parseada.css('span.value')[9].text
      f.segmento = pagina_parseada.css('span.value')[4].text.split(':').last.strip
      f.data_const = pagina_parseada.css('span.value')[6].text
      f.num_cotas_emitidas = pagina_parseada.css('span.value')[7].text
      f.tipo_gestao = pagina_parseada.css('span.value')[5].text.split(' ').last.strip
    rescue StandardError
      nil
    end
  end

  def self.extrai_taxa_adm(ticker)
    url = "https://fiis.com.br/#{ticker}/?aba=indicadores"
    regex = /([Aa]dministra[cç][aã]o)(\s*)(:)(\s*)(\d*,\d*\s?%\s?a.[amd])/i

    pagina = HTTParty.get(url)
    pagina_parseada = Nokogiri::HTML(pagina)

    tabela = pagina_parseada.search('table').first
    tx_adm = tabela.css('tr > td').text.match regex

    tx_adm[5]
  end

  def self.salva(fundo)
    fundo.save!
  end
end
