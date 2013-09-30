class SubCategoriaEmLancamentosRotinas < ActiveRecord::Migration
  def change
     add_column :lancamentos, :sub_categoria_id, :integer
     add_column :rotinas, :sub_categoria_id, :integer
  end
end
