Dado('que eu estou na página inicial') do
  visit(root_path)
end

Dado('que o {string} consta em meus favoritos') do |string|
  expect(page).to have_content(string.upcase)
end

Quando('eu clicar no {string}') do |string|
  expect(page).to have_selector(:css, "a[href=\"integra/#{string}\"]")
end

Então('deve ser exibida a página com as informações integradas do {string}') do |string|
  visit("/integra/#{string}")

  within('h3.title') do
    expect(page).to have_content(string.upcase)
  end

  expect(page).to have_content('Segmento de atuação')
  expect(page).to have_content('Preço do ativo atualmente')
  expect(page).to have_content('Taxa de Administração')
  expect(page).to have_content('Histórico')
  expect(page).to have_content('Informações')
  expect(page).to have_content('Notícias relevantes')
end