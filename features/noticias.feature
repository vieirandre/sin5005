#language:pt
@noticias
Funcionalidade: recuperar notícias relevantes aos fundos
  Para prover notícias de fundos ao usuário
  Como desenvolvedor do sistema
  Eu quero recuperar as notícias relevantes aos fundos

  Esquema do Cenário: recuperar notícias relevantes de fundos de investimento imobiliário
    Quando chamar a API de notícias informando um <termo> válido
    Então devem ser retornadas as notícias do fundo informado
    Exemplos:
      | termo |
      | "abcp11" |
      | "knri11" |