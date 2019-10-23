require 'rails_helper'
require 'simplecov'

# RSpec.describe DadosFundo, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

SimpleCov.start
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
			puts "asdasdhasudhasudhasudhsaduhsad"
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
end