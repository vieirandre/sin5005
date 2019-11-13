class RemoveDiaDistribuicaoFromDadosFundos < ActiveRecord::Migration[5.2]
  def change
    remove_column :dados_fundos, :diaDistribuicao, :string
  end
end
