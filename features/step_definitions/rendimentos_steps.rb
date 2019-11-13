Quando('chamar a API de rendimentos informando um {string} válido') do |string|
  visit("/dados_fundos?cnpj=#{string}")
end

Então('devem ser retornados os rendimentos do fundo informado') do
  within('table#tabelaRendimentosAtivo') do
    expect(all('tr').count).to be >= 1
  end
end