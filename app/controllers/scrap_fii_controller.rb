class ScrapFiiController < ApplicationController
	require 'nokogiri'
	require 'open-uri'

	def pegarValorComRegex(regex1, regex2, texto)
		resultadoRegex1 = texto.scan(regex1)
		if (!resultadoRegex1.empty? && !resultadoRegex1.first.empty? && !resultadoRegex1.first.first.empty?)
			resultadoRegex1 = resultadoRegex1.first.first.to_s
			resultadoRegex2 = resultadoRegex1.scan(regex2)
			if (!resultadoRegex2.empty? && !resultadoRegex2.first.empty? && !resultadoRegex2.first.first.empty?)
				resultado = resultadoRegex2.first.first.to_s
			else
				resultado = '-'
			end
		else
			resultado = '-'
		end
	end

	def realizarScrapFii(codigo)
		# Fetch and parse HTML document
		begin
			site = "https://fiis.com.br/" + codigo
			doc = Nokogiri::HTML(open(site))
			items = []
			numeroDeNoticias = 0
			numeroDeRendimentos = 0
			doc.css('.entry-content ul li').each do |link|
				numeroDeNoticias = numeroDeNoticias + 1
				if link.content.include? "Informou distribuição de:"
					regexMonetario = /(([0-9]*),([0-9]*))/i
					regexData = /(([0-9]*)\/([0-9]*)\/([0-9]*))/i

					regexRendimento = /(Rendimento no valor de R\$ ([0-9]*),([0-9]*))/i
					rendimento = pegarValorComRegex(regexRendimento, regexMonetario, link.content)

					regexDiaDaDistribuicao = /(por cota no dia ([0-9]*)\/([0-9]*)\/([0-9]*))/i
					diaDaDistribuicao = pegarValorComRegex(regexDiaDaDistribuicao, regexData, link.content)

					regexValorAtivoFechamento = /((\s)*Fechamento\:(\s)*R\$(\s)*([0-9]*),([0-9]*))/i
					valorAtivoFechamento = pegarValorComRegex(regexValorAtivoFechamento, regexMonetario, link.content)

					regexDataBaseFechamento = /(Data base: ([0-9]*)\/([0-9]*)\/([0-9]*))/i
					dataBaseFechamento = pegarValorComRegex(regexDataBaseFechamento, regexData, link.content)
					
					# puts "Rendimento: " + rendimento
					# puts "diaDaDistribuicao: " + diaDaDistribuicao
					# puts "valorAtivoFechamento: " +valorAtivoFechamento
					# puts "dataBaseFechamento: " + dataBaseFechamento

					item = {}
					item['rendimento'] = rendimento
					item['diaDaDistribuicao'] = diaDaDistribuicao
					item['valorAtivoFechamento'] = valorAtivoFechamento
					item['dataBaseFechamento'] = dataBaseFechamento


					items.push(item)
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
				return "O código '" + codigo + "' não existe. Verifique e tente novamente"
			else
				raise e
			end
		end
	end

	def pegarCodigoEChamarScrap
		if(params.has_key?(:codigo))
			codigo = params[:codigo]
			puts "O CÓDIGO É: " + codigo
			if (codigo != "")
				return realizarScrapFii(codigo)
			else
				return "Erro: Nenhum código foi informado"
			end
		else
			return "Erro: Informe o código do ativo pelo parâmetro 'codigo'"
		end
	end

	def scrapFii
		@teste = 10
		@ngiri = pegarCodigoEChamarScrap
	end
end