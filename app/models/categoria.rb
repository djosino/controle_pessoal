class Categoria < ActiveRecord::Base
   belongs_to :user
   has_many :lancamentos

   default_scope { order(:descricao => :asc) }
end
