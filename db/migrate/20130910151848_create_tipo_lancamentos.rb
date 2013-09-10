class CreateTipoLancamentos < ActiveRecord::Migration
  def change
    create_table :tipo_lancamentos do |t|
      t.string :descricao

      t.timestamps
    end
    TipoLancamento.create(:descricao => "Crédito")
    TipoLancamento.create(:descricao => "Débito")
  end
end
