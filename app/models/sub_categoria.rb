class SubCategoria < ActiveRecord::Base
  belongs_to :categoria
  belongs_to :user
  has_many :rotinas
  has_many :lancamentos
  
  validates_presence_of :descricao

  default_scope { order(:descricao => :asc) }
end
