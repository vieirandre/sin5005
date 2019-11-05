class CreateUsuarios < ActiveRecord::Migration[5.2]
  def change
    create_table :usuarios do |t|
      t.string :login
      t.string :senha
      t.string :nome

      t.timestamps
    end
  end
end
