class CreateUsuarios < ActiveRecord::Migration[5.2]
  def change
    create_table :usuarios do |t|
      t.string :email
      t.string :nome
      t.string :password_digest

      t.timestamps
    end
    add_index :usuarios, :email, unique: true
  end
end
