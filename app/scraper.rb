require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper
  # lista de fundos
  url = 'https://www.fundsexplorer.com.br/funds/'
  pag_nao_parseada = HTTParty.get(url)
  pag_parseada = Nokogiri::HTML(pag_nao_parseada)
  lista_fundos = pag_parseada.css('span.symbol')
  contagem_fundos = lista_fundos.count
  primeiro_lista = lista_fundos[0]
  nome_fundo = primeiro_lista.children[0].text

  # fundo ABCP11
  fundo_url = 'https://www.fundsexplorer.com.br/funds/abcp11/'
  fundo_pag_nao_parseada = HTTParty.get(fundo_url)
  fundo_pag_parseada = Nokogiri::HTML(fundo_pag_nao_parseada)
  preco = fundo_pag_parseada.css('span.price')[0].text.tr('\n', '').strip

  byebug
end

scraper