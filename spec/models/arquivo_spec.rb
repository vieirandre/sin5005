require 'rails_helper'

RSpec.describe Arquivo do
	context "set an url" do 
		it "sets an url to caminhoArquivo" do
			url = "https://www.w3schools.com/xml/note.xml"
			arquivo = Arquivo.new(url)
			expect(arquivo.instance_variable_get(:@caminhoArquivo)).to be_eql(url)
		end
		it "is expected to getDocument be false" do
			url = "https://www.w3schools.com/xml/note.xml"
			arquivo = Arquivo.new(url)
			expect(arquivo.getDocumento).to be_eql(false)
		end
		it "is expected to getErro be false" do
			url = "https://www.w3schools.com/xml/note.xml"
			arquivo = Arquivo.new(url)
			expect(arquivo.getErro).to be_eql(false)
		end
		it "is expected to getErroTraduzido be false" do
			url = "https://www.w3schools.com/xml/note.xml"
			arquivo = Arquivo.new(url)
			expect(arquivo.getErroTraduzido).to be_eql(false)
		end
	end
	{
		'https://www.w3schools.com/xml/note.xml',
		'https://webscraper.io/test-sites/tables',
	}.each do |arg, result|
		it "Applying #{arg} in the caminhoArquivo expect to set arquivoAberto to be different then #{result}" do
			arquivo = Arquivo.new(arg)
			allow(arquivo).to receive(:open).and_return('External Link')
			arquivo.abrirArquivo
			expect(arquivo.instance_variable_get(:@arquivoAberto)).to be_eql('External Link')
		end
		it "Applying #{arg} in the caminhoArquivo expect to set aplicarNokogiriSite to not be false" do
			arquivo = Arquivo.new(arg)
			arquivo.abrirArquivo
			arquivo.aplicarNokogiriSite
			expect(arquivo.instance_variable_get(:@documento)).to_not be_eql(false)
		end
		it "Applying #{arg} in the caminhoArquivo expect to set aplicarNokogiriXML to not be false" do
			arquivo = Arquivo.new(arg)
			arquivo.abrirArquivo
			arquivo.aplicarNokogiriXML
			expect(arquivo.instance_variable_get(:@documento)).to_not be_eql(false)
		end

	end

	{
		'http://thissitedoesntexists.com.br' => "404"
	}.each_pair do |arg, result|
		it "Applying #{arg} in the url should return #{result}" do
			arquivo = Arquivo.new(arg)
			allow(arquivo).to receive(:open).and_raise(result)
			expect{arquivo.abrirArquivo}.to raise_error(result)
		end
	end
end
