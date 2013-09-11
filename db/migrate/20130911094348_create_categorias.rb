class CreateCategorias < ActiveRecord::Migration
  def change
  	drop_table :categoria
    create_table :categorias do |t|
      t.references :user, index: true
      t.string :descricao
      t.references :tipo_lancamento, index: true
      t.timestamps
    end
  end
end
