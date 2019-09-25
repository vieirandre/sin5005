json.extract! fundo, :id, :ticker, :nome, :cnpj, :segmento, :tx_adm, :data_const, :num_cotas_emitidas, :patrimonio_inicial, :valor_inicial_cota, :prazo, :tipo_gestao, :created_at, :updated_at
json.url fundo_url(fundo, format: :json)
