json.extract! usuario, :id, :login, :senha, :nome, :created_at, :updated_at
json.url usuario_url(usuario, format: :json)
