class RemovePrecoAtivoNoFechamentoFromDadosFundos < ActiveRecord::Migration[5.2]
  def change
    remove_column :dados_fundos, :precoAtivoNoFechamento, :string
  end
end
