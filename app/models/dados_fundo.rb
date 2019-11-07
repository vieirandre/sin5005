class DadosFundo < ApplicationRecord
	require_relative 'arquivo'

	def self.pegarLinksDoXml(cnpj)
		url = "https://fnet.bmfbovespa.com.br/fnet/publico/pesquisarGerenciadorDocumentosCVM?paginaCertificados=false&tipoFundo=1&administrador=&cnpjFundo=".concat(cnpj,"&idCategoriaDocumento=14&idTipoDocumento=41&idEspecieDocumento=0&situacao=&cnpj=&dataReferencia=&dataInicial=&dataFinal=&idModalidade=&palavraChave=")
		arquivo = Arquivo.new(url)
		arquivo.abrirArquivo
		arquivo.aplicarNokogiriSite
		documento = arquivo.getDocumento
		if documento
			links = documento.css('a[title="Download do Documento"]').map { |link| link['href'] }
			return links
		else
			return documento.getErroTraduzido || documento.getErro
		end
	end

	def self.gerarDocumentoDadoFundo(caminhoArquivo)
		url = "https://fnet.bmfbovespa.com.br/fnet/publico/".concat(caminhoArquivo)
		arquivo = Arquivo.new(url)
		arquivo.abrirArquivo
		arquivo.aplicarNokogiriXML
		documento = arquivo.getDocumento
		return documento
	end

	def self.gerarItemDadoFundo(documento)
		if documento
			item = {}
			item['codigoAtivo'] = documento.at_css("CodNegociacaoCota").content
			item['rendimento'] = documento.at_css("ValorProventoCota").content
			item['diaPagamento'] = documento.at_css("DataPagamento").content
			item['dataBase'] = documento.at_css("DataBase").content
			return item
		else
			return documento.getErroTraduzido || documento.getErro
		end
	end

	def self.gerarDadosFundo(cnpj)
		linksComRendimento = pegarLinksDoXml(cnpj)
		dadosFundo = []
		linksComRendimento.each do |caminhoArquivo|
			item = gerarItemDadoFundo(gerarDocumentoDadoFundo(caminhoArquivo))
			if item.is_a?(Hash)
				dadosFundo.push(item)
			else
				puts item
			end
		end
		return dadosFundo
	end

	def self.salvarDados(listaResultados)
		if (listaResultados.kind_of?(Array))
			listaResultados.each do |item|
				dataBase = item['dataBase']
				codigoAtivo = item['codigoAtivo']
				acao = DadosFundo.where(:codigoAtivo => codigoAtivo, :dataBase => dataBase).first_or_create do |fundo|
					fundo.rendimento = item['rendimento']
					fundo.diaPagamento = item['diaPagamento']
				end
			end
			return true
		else
			return false
		end
	end
end