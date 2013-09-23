class RotinaIdToLancamentos < ActiveRecord::Migration
  def change
  	add_column :lancamentos, :rotina_id, :integer  
  end
end
