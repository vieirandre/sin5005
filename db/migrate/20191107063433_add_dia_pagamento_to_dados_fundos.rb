class AddDiaPagamentoToDadosFundos < ActiveRecord::Migration[5.2]
  def change
    add_column :dados_fundos, :diaPagamento, :string
  end
end
