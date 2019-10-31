require 'rails_helper'

# RSpec.describe DadosFundo, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe DadosFundo do
	#Teste do metodo aplicarRegex
	{
		{
			'regex' => /(([0-9][0-9])\/([0-9][0-9])\/(([0-9][0-9])?[0-9][0-9]))/i,
			'text' => 'Test 04/02/1994 hey'
		} => '04/02/1994',
		{
			'regex' => /(([0-9][0-9])\/([0-9][0-9])\/(([0-9][0-9])?[0-9][0-9]))/i,
			'text' => 'Esse texto nao funciona'
		} => '-',
	}.each_pair do |args, result|
		it "Applying #{args['regex']} to the text #{args['text']} should return #{result}" do
			DadosFundo.aplicarRegex(args['regex'],args['text']).should == result
		end
	end

	#Teste do metodo verificaResultadoRegexValido
	{'a' => true, '-' => false}.each_pair do |arg, result|
		it "#{arg} should return #{result}" do
			DadosFundo.verificaResultadoRegexValido(arg).should == result
		end
	end

	#Teste do metodo recuperarInformacaoComRegex
	{
		{
			'regexGeral' => /(por(\s)*cota(\s)*no(\s)*dia(\s)*([0-9]*)\/([0-9]*)\/([0-9]*))/i,
			'regexEspecifico' => /(([0-9][0-9])\/([0-9][0-9])\/(([0-9][0-9])?[0-9][0-9]))/i,
			'text' => 'por cota no dia 14/10/2019'
		} => '14/10/2019',
		{
			'regexGeral' => /(por(\s)*cota(\s)*no(\s)*dia(\s)*([0-9]*)\/([0-9]*)\/([0-9]*))/i,
			'regexEspecifico' => /(([0-9][0-9])\/([0-9][0-9])\/(([0-9][0-9])?[0-9][0-9]))/i,
			'text' => 'Esse texto nao funciona'
		} => '-',
	}.each_pair do |args, result|
		it "Applying #{args['regexGeral']} and #{args['regexEspecifico']} to the text #{args['text']} should return #{result}" do
			DadosFundo.recuperarInformacaoComRegex(args['regexGeral'],args['regexEspecifico'],args['text']).should == result
		end
	end

	#Teste da funcao regexMonetario
	result = /(((([0-9][0-9][0-9])\.)*)?([0-9]?[0-9]?[0-9])\,([0-9][0-9]))/i
	it "Should return #{result}" do
		DadosFundo.regexMonetario.should == result
	end

	#Teste da funcao regexData
	result2 = /(([0-9][0-9])\/([0-9][0-9])\/(([0-9][0-9])?[0-9][0-9]))/i
	it "Should return #{result2}" do
		DadosFundo.regexData.should == result2
	end

	#Teste do metodo pegarRendimento
	{
		'Rendimento no valor de R$ 0,74' => '0,74',
		'Nao vai funcionar nesse caso' => '-',
	}.each_pair do |arg, result|
		it "With #{arg} should return #{result}" do
			DadosFundo.pegarRendimento(arg).should == result
		end
	end

	#Teste do metodo pegarDiaDaDistribuicao
	{
		'por cota no dia 14/10/2019' => '14/10/2019',
		'Nao vai funcionar nesse caso' => '-',
	}.each_pair do |arg, result|
		it "With #{arg} should return #{result}" do
			DadosFundo.pegarDiaDaDistribuicao(arg).should == result
		end
	end

	#Teste do metodo pegarValorAtivoDiaDeFechamento
	{
		'Fechamento: R$ 160,20' => '160,20',
		'Nao vai funcionar nesse caso' => '-',
	}.each_pair do |arg, result|
		it "With #{arg} should return #{result}" do
			DadosFundo.pegarValorAtivoDiaDeFechamento(arg).should == result
		end
	end

	#Teste do metodo pegarDataBaseFechamento
	{
		'Data base: 30/09/2019' => '30/09/2019',
		'Nao vai funcionar nesse caso' => '-',
	}.each_pair do |arg, result|
		it "With #{arg} should return #{result}" do
			DadosFundo.pegarDataBaseFechamento(arg).should == result
		end
	end

	#Teste do metodo verificarSeExisteAlgumRendimento
	{
		'Informou distribuição de:' => true,
		'Nao vai funcionar nesse caso' => false,
	}.each_pair do |arg, result|
		it "With #{arg} should return #{result}" do
			DadosFundo.verificarSeExisteAlgumRendimento(arg).should == result
		end
	end

	#Teste do metodo gerarItem
	{
		{
			'conteudo' => '30/09/19 18:18 - Informou distribuição de:<br>Rendimento no valor de R$ 0,74 por cota no dia 14/10/2019<br>Data base: 30/09/2019 Fechamento: R$  160,20 Rendimento%: 0,462:',
			'itens' => [],
			'numeroDeRentimentos' => 0
		} => 1,
		{
			'conteudo' => 'Nao vai funcionar nesse caso',
			'itens' => [],
			'numeroDeRentimentos' => 0
		} => 0,
	}.each_pair do |args, result|
		it "With #{args} should return #{result}" do
			DadosFundo.gerarItem(args['conteudo'], args['itens'], args['numeroDeRentimentos']).should == result
		end
	end

	#Teste do metodo traduzirErroAbrirSite
	{
		{
			'erro' => '404 Not Found',
			'codigo' => 'knri11'
		} => "O código 'knri11' não existe. Verifique e tente novamente",
		{
			'erro' => 'Nao vai funcionar esse erro',
			'codigo' => 'knri11'
		} => false,
	}.each_pair do |args, result|
		it "With #{args} should return #{result}" do
			DadosFundo.traduzirErroAbrirSite(args['erro'], args['codigo']).should == result
		end
	end

	#Teste do metodo retornoNoticiasInvestimento
	{
		{
			'numeroDeNoticias' => 3,
			'numeroDeRendimentos' => 3,
			'itens' => 'exemploItem'
		} => 'exemploItem',
		{
			'numeroDeNoticias' => 0,
			'numeroDeRendimentos' => 0,
			'itens' => 'exemploItem'
		} => 'Não existem notícias desse ativo. Verifique se ele existe',
		{
			'numeroDeNoticias' => 0,
			'numeroDeRendimentos' => 1,
			'itens' => 'exemploItem'
		} => 'Não existem notícias desse ativo. Verifique se ele existe',
		{
			'numeroDeNoticias' => 1,
			'numeroDeRendimentos' => 0,
			'itens' => 'exemploItem'
		} => 'Não houve fatos relevantes desse ativo'
	}.each_pair do |args, result|
		it "With #{args} should return #{result}" do
			DadosFundo.retornoNoticiasInvestimento(args['numeroDeNoticias'], args['numeroDeRendimentos'], args['itens']).should == result
		end
	end

	=begin
	#Teste do metodo realizarScrapFii
	#
	#Obs. Segundo codigo pode mudar os
	#resultados caso seja publicado um
	#rendimento, precisa colocar outro
	#codigo caso ocorra
	{
		'knri11' => Array,
		'sdip11' => String,
		'codigoX' => String
	}.each_pair do |arg, type|
		it "With #{arg} should return #{result}" do
			teste = DadosFundo.realizarScrapFii(arg)
			teste.kind_of?(type).should == true
		end
	end
	=end

	#Teste do metodo salvarFundo
	{
		{
			'codigo' => 'knri11',
			'listaResultados' =>[
				{"rendimento"=>"0,74", "diaDaDistribuicao"=>"30/09/19", "valorAtivoFechamento"=>"0,74", "dataBaseFechamento"=>"30/09/19"},
				{"rendimento"=>"0,74", "diaDaDistribuicao"=>"30/08/19", "valorAtivoFechamento"=>"0,74", "dataBaseFechamento"=>"30/08/19"}
			]
		} => true,
		{
			'codigo' => 'codigoErrado',
			'listaResultados' => 'erro'
		} => false
	}.each_pair do |args, result|
		it "With #{args} should return #{result}" do
			DadosFundo.salvarFundo(args['codigo'], args['listaResultados']).should == result
		end
	end

end
