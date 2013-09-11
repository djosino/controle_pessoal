class Lancamento < ActiveRecord::Base
	belongs_to :user
	belongs_to :categoria
	belongs_to :tipo_lancamento

    validates_presence_of :valor, :user_id, :tipo_lancamento_id, :categoria_id, :descricao
    default_scope { order(:id => :asc) }
end
