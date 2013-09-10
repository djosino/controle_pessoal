class CreateCategoria < ActiveRecord::Migration
  def change
    create_table :categoria do |t|
      t.references :user, index: true
      t.string :descricao

      t.timestamps
    end
  end
end
