class Lancamento < ActiveRecord::Base
	belongs_to :user
	belongs_to :categoria
	belongs_to :tipo_lancamento

    validates_presence_of :valor, :user_id, :tipo_lancamento_id, :categoria_id, :descricao

    scope :mes_atual,     -> (id,user_id) { where(["id >= ? and user_id = ?", id, user_id]) }
    scope :receita,       -> { where("tipo_lancamento_id = 1") }
    scope :despesa,       -> { where("tipo_lancamento_id = 2") }

    default_scope { order(:id => :desc) }

end
