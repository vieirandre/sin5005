require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'uri'




class NoticiasController < ApplicationController

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




  def fii

		@fii = params[:id]


		url = "https://news.google.com/rss/search?q=" + URI.escape(@fii) + "&hl=pt-BR&gl=BR&ceid=BR:pt-419"
		fii_xml = Nokogiri::XML(open(url))

		#puts fii_xml.xpath("//item")

		#puts fii_xml.xpath("//item").class

		#puts fii_xml.xpath("//item").kind_of?(Enumerable)

		@fii_xml = fii_xml


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

		
  end
end
