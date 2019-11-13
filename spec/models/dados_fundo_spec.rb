require 'rails_helper'

RSpec.describe DadosFundo do
	{
		'12005956000165' => Array,
		'12005956000160' => String,
	}.each_pair do |arg, result|
		it "Applying #{arg} in the pegarLinksDoXml expect to return #{result}" do
			expect(DadosFundo.pegarLinksDoXml(arg)).to be_kind_of(result)
		end
	end

	{
		'downloadDocumento?id=64609' => Nokogiri::XML::Document,
	}.each_pair do |arg, result|
		it "Applying #{arg} in the gerarDocumentoDadoFundo expect to return #{result}" do
			expect(DadosFundo.gerarDocumentoDadoFundo(arg)).to be_kind_of(result)
		end
	end

	describe "Create an object that needs Nokogiri object" do
		before(:all) do
			@document = Nokogiri::XML::DocumentFragment.parse ""
			Nokogiri::XML::Builder.with(@document) do |xml|
				xml.root do
					xml.fundo{
						xml.CodNegociacaoCota '1'
						xml.ValorProventoCota '2'
						xml.DataPagamento '3'
						xml.DataBase '4'
						xml.CNPJFundo '5'
					}
				end
			end
		end
		it "Applying #{@document} in the gerarItemDadoFundo expect to return #{'asd'}" do
			expect(DadosFundo.gerarItemDadoFundo(@document)).to be_kind_of(Hash)
		end
	end

	{
		'12005956000165' => Array,
		'12005956000160' => Array,
	}.each_pair do |arg, result|
		it "Applying #{arg} in the gerarDadosFundo expect to return #{result}" do
			expect(DadosFundo.gerarDadosFundo(arg)).to be_kind_of(result)
		end
	end

	{
		[
			{"rendimento"=>"0,74", "diaPagamento"=>"30/09/19", "codigoAtivo"=>"TickTest", "dataBase"=>"30/09/19", "cnpj" => "12005956000160"},
			{"rendimento"=>"0,74", "diaPagamento"=>"30/08/19", "codigoAtivo"=>"TickTest", "dataBase"=>"30/08/19", "cnpj" => "12005956000160"},
		] => true,
		'erro' => false
	}.each_pair do |arg, result|
		it "With #{arg} should return #{result}" do
			expect(DadosFundo.salvarDados(arg)).to be_eql(result)
		end
	end


end