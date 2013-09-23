class TipoLancamento < ActiveRecord::Base
   has_many :lancamentos
   has_many :categorias
   has_many :rotinas
   
   default_scope { order(:descricao => :asc) }
end
