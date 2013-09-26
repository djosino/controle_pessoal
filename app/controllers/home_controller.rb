class HomeController < ApplicationController
   def index
      lancamento = current_user.ultimo_salario
      @totais = []
      if lancamento
         lancamentos = Lancamento.mes_atual(lancamento.data_pagamento, current_user.id)
         @totais << Lancamento.mes_atual(lancamento.data_pagamento, current_user.id).count 
         @totais << Lancamento.mes_atual(lancamento.data_pagamento, current_user.id).receita.sum(:valor).to_f
         @totais << Lancamento.mes_atual(lancamento.data_pagamento, current_user.id).despesa.sum(:valor).to_f
         @totais << (@totais[1] - @totais[2])

         @totais << Lancamento.where("user_id = ?  and data_pagamento::date = current_date",current_user.id).receita.sum(:valor).to_f
         @totais << Lancamento.where("user_id = ?  and data_pagamento::date = current_date",current_user.id).despesa.sum(:valor).to_f
         @totais << (@totais[4] - @totais[5])

         dias = []
         despesas = []
         receitas = []

         dia_fim = lancamento.data_pagamento + 30.day
         dia_fim = dia_fim > Date.today ? Date.today : dia_fim
         for i in lancamento.data_pagamento..dia_fim
            dias << i.day 
            despesas << lancamentos.despesa.collect{|l| l.data_pagamento == i ? l.valor : 0.0 }.sum.round(2)
            receitas << lancamentos.receita.collect{|l| l.data_pagamento == i ? l.valor : 0.0 }.sum.round(2)
         end

         @chart = LazyHighCharts::HighChart.new('line') do |f|
            f.title({ :text=>"Relatório Mensal"})
            f.options[:xAxis][:categories] = dias 
            f.options[:yAxis][:title][:text] = "Valores"
            f.series(:type=> 'column', :name => "Receitas", :data => receitas)
            f.series(:type=> 'column', :name => "Despesas", :data => despesas, :color => "#B80000")
         end
      else
         @totais = [0,0,0,0]
      end
      @percentual = Time.percentual_dia
   end
end
