class SubCategoria < ActiveRecord::Base
  belongs_to :categoria
  belongs_to :user
  has_many :rotinas, dependent: :restrict
  has_many :lancamentos, dependent: :restrict
  
  validates_presence_of :descricao

  default_scope { order(:descricao => :asc) }
end
