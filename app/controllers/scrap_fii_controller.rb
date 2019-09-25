class ScrapFiiController < ApplicationController
	require 'nokogiri'
	require 'open-uri'

	def nokogiritest
		# Fetch and parse HTML document
		if(params.has_key?(:codigo))
			begin
				puts "O CÓDIGO É: " + params[:codigo]
				site = "https://fiis.com.br/" + params[:codigo]
				doc = Nokogiri::HTML(open(site))
				items = []
				numeroDeNoticias = 0
				numeroDeRendimentos = 0
				doc.css('.entry-content ul li').each do |link|
					numeroDeNoticias = numeroDeNoticias + 1
					if link.content.include? "Informou distribuição de:"
						items.push(link.content)
						numeroDeRendimentos = numeroDeRendimentos + 1
					end
				end
				if (numeroDeNoticias > 0)
					if (numeroDeRendimentos > 0)
						return items
					else
						return "Não houve fatos relevantes desse ativo"
					end
				else
					return "Não existem notícias desse ativo. Verifique se ele existe"
				end
			rescue OpenURI::HTTPError => e
				if e.message == '404 Not Found'
					return "O código '" + params[:codigo] + "' não existe. Verifique e tente novamente"
				else
					raise e
				end
			end
		else
			return "Erro: Informe o código do ativo pelo parâmetro 'codigo'"
		end
	end

	def scrapFii
		@teste = 10
		@ngiri = nokogiritest
	end
end