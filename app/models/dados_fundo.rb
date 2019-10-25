class DadosFundo < ApplicationRecord
	require 'nokogiri'
	require 'open-uri'

	def self.aplicarRegex(regex,texto)
		resultado = texto.scan(regex)
		if (!resultado.empty? && !resultado.first.empty? && !resultado.first.first.empty?)
			return resultado.first.first.to_s
		else
			return "-"
		end
	end

	def self.verificaResultadoRegexValido(resultado)
		if (resultado != "-")
			return true
		else
			return false
		end
	end

	def self.recuperarInformacaoComRegex(regexGeral, regexEspecifico, texto)
		resultadoRegexGeral = self.aplicarRegex(regexGeral, texto)
		if (self.verificaResultadoRegexValido(resultadoRegexGeral))
			resultado = self.aplicarRegex(regexEspecifico, texto)
		else
			resultado = '-'
		end
	end

	def self.regexMonetario
		# return /(((([0-9]*)\.)*)?([0-9]*),([0-9]*))/i
		return /(((([0-9][0-9][0-9])\.)*)?([0-9]?[0-9]?[0-9])\,([0-9][0-9]))/i
	end

	def self.regexData
		# return (([0-9]*)\/([0-9]*)\/([0-9]*))
		return /(([0-9][0-9])\/([0-9][0-9])\/(([0-9][0-9])?[0-9][0-9]))/i
	end

	def self.pegarRendimento(conteudo)
		regexRendimento = /(Rendimento(\s)*no(\s)*valor(\s)*de(\s)*R\$(\s)*(((([0-9]*)\.)*)?([0-9]*)\,([0-9]*)))/i
		return self.recuperarInformacaoComRegex(regexRendimento, self.regexMonetario, conteudo)
	end

	def self.pegarDiaDaDistribuicao(conteudo)
		regexDiaDaDistribuicao = /(por(\s)*cota(\s)*no(\s)*dia(\s)*([0-9]*)\/([0-9]*)\/([0-9]*))/i
		return self.recuperarInformacaoComRegex(regexDiaDaDistribuicao, self.regexData, conteudo)
	end

	def self.pegarValorAtivoDiaDeFechamento(conteudo)
		regexValorAtivoFechamento = /(Fechamento\:(\s)*R\$(\s)*(((([0-9]*)\.)*)?([0-9]*)\,([0-9]*)))/i
		return self.recuperarInformacaoComRegex(regexValorAtivoFechamento, self.regexMonetario, conteudo)
	end

	def self.pegarDataBaseFechamento(conteudo)
		regexDataBaseFechamento = /(Data(\s)*base:(\s)*([0-9]*)\/([0-9]*)\/([0-9]*))/i
		return self.recuperarInformacaoComRegex(regexDataBaseFechamento, regexData, conteudo)
	end

	def self.verificarSeExisteAlgumRendimento(conteudo)
		conteudo.include? "Informou distribuição de:"
	end

	def self.gerarItem(conteudo, itens, numeroDeRendimentos)
		if self.verificarSeExisteAlgumRendimento(conteudo)
			item = {}
			item['rendimento'] = self.pegarRendimento(conteudo)
			item['diaDaDistribuicao'] = self.pegarDiaDaDistribuicao(conteudo)
			item['valorAtivoFechamento'] = self.pegarValorAtivoDiaDeFechamento(conteudo)
			item['dataBaseFechamento'] = self.pegarDataBaseFechamento(conteudo)
			itens.push(item)
			numeroDeRendimentos = numeroDeRendimentos + 1
		end
		return numeroDeRendimentos
	end

	def self.traduzirErroAbrirSite(erro, codigo)
		if erro == '404 Not Found'
			return "O código '" + codigo + "' não existe. Verifique e tente novamente"
		else
			return false
		end
	end

	def self.abrirSite(codigo)
		begin
			site = "https://fiis.com.br/" + codigo
			doc = Nokogiri::HTML(open(site))
			return doc, false, false
		rescue OpenURI::HTTPError => e
			erro = traduzirErroAbrirSite(e.message, codigo)
			if !erro
				return false, e, false
			else
				return false, e, erro
			end
		end
	end

	def self.retornoNoticiasInvestimento(numeroDeNoticias, numeroDeRendimentos, itens)
		if (numeroDeNoticias == 0)
			return "Não existem notícias desse ativo. Verifique se ele existe"
		elsif (numeroDeRendimentos == 0)
			return "Não houve fatos relevantes desse ativo"
		else
			return itens
		end
	end

	def self.realizarScrapFii(codigo)
		# Fetch and parse HTML document
		doc, e, erro = self.abrirSite(codigo)
		if !e
			itens = []
			numeroDeNoticias = 0
			numeroDeRendimentos = 0
			doc.css('.entry-content ul li').each do |link|
				numeroDeNoticias = numeroDeNoticias + 1
				numeroDeRendimentos = self.gerarItem(link.content, itens, numeroDeRendimentos)
			end
			return self.retornoNoticiasInvestimento(numeroDeNoticias, numeroDeRendimentos, itens)
		else
			return erro || e
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
			return true
		else
			return false
		end
	end
end	