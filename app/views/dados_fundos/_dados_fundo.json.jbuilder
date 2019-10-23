json.extract! dados_fundo, :id, :codigoAtivo, :rendimento, :diaDistribuicao, :precoAtivoNoFechamento, :diaFechamentoDoPreco, :created_at, :updated_at
json.url dados_fundo_url(dados_fundo, format: :json)
