class Lancamento < ActiveRecord::Base
	belongs_to :user
	belongs_to :categoria
	belongs_to :tipo_lancamento
	belongs_to :rotina

    validates_presence_of :valor, :user_id, :tipo_lancamento_id, :categoria_id, :descricao, :data_pagamento

    scope :mes_atual, -> (data,user_id) { where(["data_pagamento >= ? and user_id = ?", data, user_id]).order(:data_pagamento => :asc) }
    scope :receita,   -> { where("tipo_lancamento_id = 1") }
    scope :despesa,   -> { where("tipo_lancamento_id = 2") }

    default_scope { order(:id => :desc) }

end
