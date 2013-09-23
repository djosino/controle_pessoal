class CreateRotinas < ActiveRecord::Migration
  def change
    create_table :rotinas do |t|
      t.string :descricao
      t.date :data_vencimento
      t.date :data_pagamento
      t.references :categoria, index: true
      t.references :tipo_lancamento, index: true
      t.references :user, index: true
      t.float :valor
      t.date :data_inicial
      t.date :data_final
      t.boolean :ativo

      t.timestamps
    end
  end
end
