class Categoria < ActiveRecord::Base
  belongs_to :user
  belongs_to :tipo_lancamento
  has_many :lancamentos
end
