class DadosFundo < ApplicationRecord
	require 'nokogiri'
	require 'open-uri'
	def self.pegarValorComRegex(regex1, regex2, texto)
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

	def self.realizarScrapFii(codigo)
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
					regexMonetario = /(((([0-9]*)\.)*)?([0-9]*),([0-9]*))/i
					regexData = /(([0-9]*)\/([0-9]*)\/([0-9]*))/i

					regexRendimento = /(Rendimento(\s)*no(\s)*valor(\s)*de(\s)*R\$(\s)*(((([0-9]*)\.)*)?([0-9]*),([0-9]*)))/i
					rendimento = self.pegarValorComRegex(regexRendimento, regexMonetario, link.content)

					regexDiaDaDistribuicao = /(por(\s)*cota(\s)*no(\s)*dia(\s)*([0-9]*)\/([0-9]*)\/([0-9]*))/i
					diaDaDistribuicao = self.pegarValorComRegex(regexDiaDaDistribuicao, regexData, link.content)

					regexValorAtivoFechamento = /(Fechamento\:(\s)*R\$(\s)*(((([0-9]*)\.)*)?([0-9]*),([0-9]*)))/i
					valorAtivoFechamento = self.pegarValorComRegex(regexValorAtivoFechamento, regexMonetario, link.content)

					regexDataBaseFechamento = /(Data(\s)*base:(\s)*([0-9]*)\/([0-9]*)\/([0-9]*))/i
					dataBaseFechamento = self.pegarValorComRegex(regexDataBaseFechamento, regexData, link.content)
					
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
	def self.salvarFundo(codigo, listaResultados)
		if (listaResultados.kind_of?(Array))
			listaResultados.each do |item|
				diaFechamento = item['dataBaseFechamento']
				acao = DadosFundo.where(:codigoAtivo => codigo, :diaFechamentoDoPreco => diaFechamento).first_or_create do |fundo|
					fundo.rendimento = item['rendimento']
					fundo.diaDistribuicao = item['diaDaDistribuicao']
					fundo.precoAtivoNoFechamento = item['valorAtivoFechamento']
				end
			end
		end
	end
end
