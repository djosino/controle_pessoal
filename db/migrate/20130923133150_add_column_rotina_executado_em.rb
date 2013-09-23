class AddColumnRotinaExecutadoEm < ActiveRecord::Migration
  def change
     add_column :rotinas, :ultima_execucao_em, :date
     remove_column :users, :ultima_rotina_em
  end
end
