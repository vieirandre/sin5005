Quando('chamar a API de notícias informando um {string} válido') do |string|
  visit("/noticias/fii/#{string}")
end

Então('devem ser retornadas as notícias do fundo informado') do
  within('table#news') do
    expect(all('tr').count).to be >= 1
  end
end