Quando('chamar a API informando um {string} válido') do |string|
  visit("/fundos/#{string}")
end

Então('devem ser retornados os indicadores do fundo informado') do
  json = JSON.parse(page.body)
  expect(json['status']).to eq('Sucesso')
  expect(json['message']).to eq('Fundo carregado')
end