#language:pt
@integration
Funcionalidade: apresentar página com todas as informações dos fundos
  Para me informar por completo quanto aos fundos
  Como um usuário
  Eu quero ver uma página com indicadores, rendimentos e notícias dos fundos de meu interesse

  Esquema do Cenário: exibir página de integração de informações de fundos favoritos
    Dado que eu estou na página inicial
    E que o <fundo> consta em meus favoritos
    Quando eu clicar no <fundo>
    Então deve ser exibida a página com as informações integradas do <fundo>
    Exemplos:
    | fundo |
    | "knri11" |
    | "figs11" |