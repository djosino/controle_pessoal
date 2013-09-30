class CreateSubCategorias < ActiveRecord::Migration
  def change
    create_table :sub_categorias do |t|
      t.string :descricao
      t.references :categoria, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
