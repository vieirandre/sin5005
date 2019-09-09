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

  byebug
end

scraper