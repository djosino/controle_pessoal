class TipoLancamento < ActiveRecord::Base
   has_many :lancamentos

   default_scope { order(:descricao => :asc) }
end
