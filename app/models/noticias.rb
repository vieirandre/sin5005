class Noticias < ApplicationRecord

  require 'nokogiri'
  require 'open-uri'

	class Noticia
		attr_accessor :titulo
  		attr_accessor :link
  		attr_accessor :descricao

		def initialize(titulo, link, descricao)
    		@titulo = titulo
    		@link = link
    		@descricao = descricao
  		end  		

  	end

	def self.pesquisa(termo)
		url = "https://news.google.com/rss/search?q=" + termo + "&hl=pt-BR&gl=BR&ceid=BR:pt-419"
		
		
		return Nokogiri::XML(open(url)) 
	end

	def self.extrairinformacoes(fii_xml)

		@lista_noticias = []

		titulo = ""
		link = ""
		descricao = ""	

		fii_xml.xpath("//item/*").each{|e|

			if e.name == 'title'
				titulo = e.text
			end
			
			if e.name == 'link'
				link = e.text
			end
			
			if e.name == 'description'
				descricao = e.text
				@lista_noticias << Noticia.new(titulo,link,descricao)
			end	

		} 

		return @lista_noticias
	end

  	def self.lista(fii)

  			@lista_noticias = []

			#url = "https://news.google.com/rss/search?q=" + URI.escape(@fii) + "&hl=pt-BR&gl=BR&ceid=BR:pt-419"
			fii_xml = pesquisa(fii)

			#puts fii_xml.xpath("//item")

			#puts fii_xml.xpath("//item").class

			#puts fii_xml.xpath("//item").kind_of?(Enumerable)

			#@fii_xml = fii_xml

			@lista_noticias = extrairinformacoes(fii_xml) 
			

			return @lista_noticias

  	end

	


end
