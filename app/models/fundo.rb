class Fundo < ApplicationRecord
  require 'httparty'
  require 'nokogiri'

  def self.scrap(ticker)
    url = "https://www.fundsexplorer.com.br/funds/#{ticker}/"
    pag_nao_parseada = HTTParty.get(url)
    pag_parseada = Nokogiri::HTML(pag_nao_parseada)
    title = pag_parseada.title

    return if title['500'] || title['400'] || title['404']

    fundo = extrair_infos(ticker, pag_parseada)

    salvar(fundo)
  end

  def self.popula
    url = 'https://www.fundsexplorer.com.br/funds/'
    pag_nao_parseada = HTTParty.get(url)
    pag_parseada = Nokogiri::HTML(pag_nao_parseada)
    lista_fundos = pag_parseada.css('span.symbol')
    # contagem_fundos = lista_fundos.count

    lista_fundos.each do |fundo|
      ticker = fundo.children[0].text.upcase
      scrap(ticker) if Fundo.find_by_ticker(ticker).nil?
    end
  end

  private

  def self.extrair_infos(ticker, pag_parseada)
    Fundo.new do |f|
      f.ticker = ticker
      f.preco = pag_parseada.css('span.price')[0].text.delete('R$').strip
      f.nome = pag_parseada.css('h2.section-subtitle')[0].text
      f.cnpj = pag_parseada.css('span.description')[8].text.strip
      f.segmento = pag_parseada.css('span.description')[11].text.strip
      f.tx_adm = pag_parseada.css('span.description')[13].text.strip.delete('^0-9.').chomp('.')
      f.data_const = pag_parseada.css('span.description')[1].text.strip
      f.num_cotas_emitidas = pag_parseada.css('span.description')[2].text.strip
      f.patrimonio_inicial = pag_parseada.css('span.description')[3].text.delete('R$').strip
      f.valor_inicial_cota = pag_parseada.css('span.description')[4].text.delete('R$').strip
      f.prazo = pag_parseada.css('span.description')[12].text.strip
      f.tipo_gestao = pag_parseada.css('span.description')[5].text.strip
    end
  end

  def self.salvar(fundo)
    fundo.save
  end
end