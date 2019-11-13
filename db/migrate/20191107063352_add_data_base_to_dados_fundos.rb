class AddDataBaseToDadosFundos < ActiveRecord::Migration[5.2]
  def change
    add_column :dados_fundos, :dataBase, :string
  end
end
