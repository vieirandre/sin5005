#language:pt
@usuario
Funcionalidade: criar novo usuário
  Para que eu possa administrar meus investimentos
  Como um usuário
  Eu quero poder acessar a plataforma via nome de usuário e senha

  Esquema do Cenário: cadastro do usuário
    Dado que o usuário está na página principal
    E clica no botão de novo usuário
    Quando preencher <nome de usuário>, <senha> e <e-mail>
    E clicar em criar usuário
    Então deve ser cadastrado com sucesso
    Exemplos:
      | nome de usuário | senha | e-mail |
      | "Bruno Sanchez" | "123" | "bsanchez@hotmail.com" |
      | "Rodrigo Polamaro" | "321" | "rpolamaro@gmail.com" |

  Cenário: login do usuário
    Dado que o usuário está cadastrado
    E que o usuário está na página principal
    E que o usuário clica em login
    Quando preencher e-mail e senha
    E clicar em login
    Então ele estará logado