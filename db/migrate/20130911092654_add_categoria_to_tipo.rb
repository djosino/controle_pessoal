class AddCategoriaToTipo < ActiveRecord::Migration
  def change
    add_column :categoria, :tipo_lancamento_id, :integer  
  end
end
