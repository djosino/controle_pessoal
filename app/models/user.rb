class User < ActiveRecord::Base
   # Include default devise modules. Others available are:
   # :token_authenticatable, :confirmable,
   # :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :timeoutable #, :confirmable, 

   has_many :categorias
   has_many :lancamentos
   has_many :rotinas

   after_create :criar_categorias

   def criar_categorias
      Categoria.create(:user_id => self.id, :descricao => "Pessoal",                 :tipo_lancamento_id => 2)
      Categoria.create(:user_id => self.id, :descricao => "Transporte - Manutenção", :tipo_lancamento_id => 2)
      Categoria.create(:user_id => self.id, :descricao => "Transporte - Gasolina",   :tipo_lancamento_id => 2)
      Categoria.create(:user_id => self.id, :descricao => "Alimentação",             :tipo_lancamento_id => 2)
      Categoria.create(:user_id => self.id, :descricao => "Despesas Bancárias",      :tipo_lancamento_id => 2)
   end

    def ultimo_salario
    	Lancamento.where(["categoria_id = 1 and user_id = ?", self.id]).last
    end
end
