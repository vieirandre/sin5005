class CreateTiles < ActiveRecord::Migration[5.2]
  def change
    create_table :tiles do |t|
      t.belongs_to :usuarios, foreign_key: true
      t.belongs_to :fundos, foreign_key: true

      t.timestamps
    end
  end
end
