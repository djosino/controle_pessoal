class TipoLancamento < ActiveRecord::Base
   has_many :lancamentos
   has_many :categorias

   default_scope { order(:descricao => :asc) }
end
