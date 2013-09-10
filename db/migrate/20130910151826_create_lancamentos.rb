class CreateLancamentos < ActiveRecord::Migration
  def change
    create_table :lancamentos do |t|
      t.string :descricao
      t.date :data_vencimento
      t.date :data_pagamento
      t.float :valor
      t.integer :tipo_lancamento_id
      t.integer :categoria_id
      t.integer :user_id

      t.timestamps
    end
  end
end
