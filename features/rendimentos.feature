#language:pt
@rendimentos
Funcionalidade: recuperar rendimentos de fundos
  Para prover rendimentos de fundos ao usuário
  Como desenvolvedor do sistema
  Eu quero recuperar os rendimentos via scrap de sites do ramo

  Esquema do Cenário: recuperar rendimentos de fundos de investimento imobiliário
    Quando chamar a API de rendimentos informando um <cnpj> válido
    Então devem ser retornados os rendimentos do fundo informado
    Exemplos:
      | cnpj |
      | "01201140000190" |
      | "12005956000165" |