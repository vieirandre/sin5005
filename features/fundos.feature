#language:pt
@scrap_fundos
Funcionalidade: recuperar indicadores de fundos
  Para prover informações de fundos ao usuário
  Como desenvolvedor do sistema
  Eu quero recuperar as informações via scrap de sites do ramo

  Esquema do Cenário: recuperar indicadores de fundos de investimento imobiliário
    Quando chamar a API informando um <ticker> válido
    Então devem ser retornados os indicadores do fundo informado
    Exemplos:
      | ticker |
      | "abcp11" |
      | "knri11" |