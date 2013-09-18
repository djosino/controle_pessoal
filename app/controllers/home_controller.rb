class HomeController < ApplicationController
  	def index
  	  	lancamento = current_user.ultimo_salario
      @totais = []
      if lancamento
         @totais << Lancamento.mes_atual(lancamento.id, current_user.id).count 
         @totais << Lancamento.mes_atual(lancamento.id, current_user.id).receita.sum(:valor).to_f
         @totais << Lancamento.mes_atual(lancamento.id, current_user.id).despesa.sum(:valor).to_f
         @totais << (@totais[1] - @totais[2])

         @totais << Lancamento.where("user_id = ?  and data_pagamento::date = current_date",current_user.id).receita.sum(:valor).to_f
         @totais << Lancamento.where("user_id = ?  and data_pagamento::date = current_date",current_user.id).despesa.sum(:valor).to_f
         @totais << (@totais[4] - @totais[5])
      else
         @totais = [0,0,0,0]
      end
  	end
end
