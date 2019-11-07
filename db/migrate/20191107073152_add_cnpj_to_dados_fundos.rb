class AddCnpjToDadosFundos < ActiveRecord::Migration[5.2]
  def change
    add_column :dados_fundos, :cnpj, :string
  end
end
