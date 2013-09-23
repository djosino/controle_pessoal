class Rotina < ActiveRecord::Base
   belongs_to :categoria
   belongs_to :tipo_lancamento
   belongs_to :user
   has_many :lancamentos

   validates_presence_of :valor, :user_id, :tipo_lancamento_id, :categoria_id, :descricao, :data_inicial, :data_final

   default_scope { order(:id => :desc) }
end
