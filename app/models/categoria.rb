class Categoria < ActiveRecord::Base
  belongs_to :user
  belongs_to :tipo_lancamento
  has_many :lancamentos

  validates_presence_of :descricao, :tipo_lancamento_id

  
  default_scope { order(:descricao => :asc) }
end
