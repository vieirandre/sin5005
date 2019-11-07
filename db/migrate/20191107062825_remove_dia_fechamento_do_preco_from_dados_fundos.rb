class RemoveDiaFechamentoDoPrecoFromDadosFundos < ActiveRecord::Migration[5.2]
  def change
    remove_column :dados_fundos, :diaFechamentoDoPreco, :string
  end
end
