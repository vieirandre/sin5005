json.extract! dados_fundo, :id, :codigoAtivo, :rendimento, :created_at, :updated_at, :dataBase, :diaPagamento, :cnpj
json.url dados_fundo_url(dados_fundo, format: :json)
