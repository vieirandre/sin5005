Dado('que o usuário está na página principal') do
  visit(root_path)
end

Dado('clica no botão de novo usuário') do
  click_link('Novo Usuário')
end

Quando('preencher {string}, {string} e {string}') do |string, string2, string3|
  fill_in('usuario_email', with: string3)
  fill_in('usuario_nome', with: string)
  fill_in('usuario_password', with: string2)
  fill_in('usuario_password_confirmation', with: string2)
end

Quando('clicar em criar usuário') do
  click_button('Create Usuario')
end

Então('deve ser cadastrado com sucesso') do
  expect(page).to have_content('Usuario was successfully created')
end

Dado('que o usuário está cadastrado') do
  usuario = Usuario.new(email: 'bsanchez@hotmail.com', nome: 'Bruno Sanchez', password_digest: Usuario.digest('123'))
  usuario.save
end

Dado('que o usuário clica em login') do
  click_link('Log In')
end

Quando('preencher e-mail e senha') do
  fill_in('email', with: 'bsanchez@hotmail.com')
  fill_in('password', with: '123')
end

Quando('clicar em login') do
  click_button('Login')
end

Então('ele estará logado') do
  expect(page).to have_text('Log Out')
end