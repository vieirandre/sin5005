class CreateDadosFundos < ActiveRecord::Migration[5.2]
  def change
    create_table :dados_fundos do |t|
      t.string :codigoAtivo
      t.string :rendimento
      t.string :diaDistribuicao
      t.string :precoAtivoNoFechamento
      t.string :diaFechamentoDoPreco

      t.timestamps
    end
  end
end
