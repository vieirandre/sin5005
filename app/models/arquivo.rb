class Arquivo
	require 'nokogiri'
	require 'open-uri'
	require 'openssl'
	OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

	def initialize(caminhoArquivo)
		@caminhoArquivo = caminhoArquivo
		@arquivoAberto = false
		@documento = false
		@erro = false
		@erroTraduzido = false
	end

	def traduzirErroAbrirArquivo
		if @erro.message == '404 Not Found'
			@erroTraduzido = "Não foi achado. Verifique os dados e tente novamente"
		end
	end

	def abrirArquivo
		begin
			@arquivoAberto = open(@caminhoArquivo)
		rescue OpenURI::HTTPError => erro
			@erro = erro
			traduzirErroAbrirArquivo
		end
	end

	def aplicarNokogiriSite
		if @arquivoAberto
			@documento = Nokogiri::HTML(@arquivoAberto)
		end
	end

	def aplicarNokogiriXML
		if @arquivoAberto
			@documento = Nokogiri::XML(@arquivoAberto)
		end
	end

	def getDocumento
		return @documento
	end

	def getErro
		return @erro
	end

	def getErroTraduzido
		return @erroTraduzido
	end
end