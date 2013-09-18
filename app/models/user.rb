class User < ActiveRecord::Base
   # Include default devise modules. Others available are:
   # :token_authenticatable, :confirmable,
   # :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :timeoutable #, :confirmable, 

   has_many :categorias
   has_many :lancamentos

    def ultimo_salario
    	Lancamento.where(["categoria_id = 1 and user_id = ?", self.id]).last
    end
end
