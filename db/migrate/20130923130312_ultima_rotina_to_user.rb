class UltimaRotinaToUser < ActiveRecord::Migration
  def change
  	add_column :users, :ultima_rotina_em, :date  
  end
end
