class HomeController < ApplicationController

   def consultas
   end

   def por_mes_ano
      @data = Date.new(params[:ano].to_i, params[:mes].to_i, 10)
      @lancamentos = Lancamento.mes_atual(@data, current_user.id)
      @inicial = @data.beginning_of_month
      @final = @data.end_of_month
      monta_relatorio
      @lancamentos = Lancamento.mes_atual(@data, current_user.id).order(:data_pagamento => :asc)   
   end

   def index
      @totais = []
      @data = Date.today
      @lancamentos = Lancamento.mes_atual(@data, current_user.id)
      if @data.day < 15
        @inicial = @data.beginning_of_month
        @final = Date.new(@data.year, @data.month, 15)
      else
        @final = @data
        @inicial = @data.days_ago(15)
      end
      monta_relatorio
   end

   private
   def monta_relatorio
      @totais = []
      @totais << Lancamento.mes_atual(@data, current_user.id).count 
      @totais << Lancamento.mes_atual(@data, current_user.id).receita.sum(:valor).to_f
      @totais << Lancamento.mes_atual(@data, current_user.id).despesa.sum(:valor).to_f
      @totais << (@totais[1] - @totais[2])

      @totais << Lancamento.where("user_id = ?  and data_pagamento::date = current_date",current_user.id).receita.sum(:valor).to_f
      @totais << Lancamento.where("user_id = ?  and data_pagamento::date = current_date",current_user.id).despesa.sum(:valor).to_f
      @totais << (@totais[4] - @totais[5])

      dias = []
      despesas = []
      receitas = []
      saldo = []

      for i in @inicial..@final
         dias << i.day 
         despesas << @lancamentos.despesa.collect{|l| l.data_pagamento == i ? l.valor : 0.0 }.sum.round(2)
         receitas << @lancamentos.receita.collect{|l| l.data_pagamento == i ? l.valor : 0.0 }.sum.round(2)
         saldo    << receitas.sum -  despesas.sum
      end

      @chart = LazyHighCharts::HighChart.new('line') do |f|
         f.title({ :text=>"Relatório Mensal"})
         f.options[:xAxis][:categories]   = dias 
         f.options[:yAxis][:title][:text] = "Valores"
         f.options[:yAxis][:max]          = [despesas.max, receitas.max, saldo.max].max
         f.series(:type=> 'spline', :name => "Saldo", :data => saldo)
         f.series(:type=> 'spline', :name => "Receitas", :data => receitas, :color => "green")
         f.series(:type=> 'spline', :name => "Despesas", :data => despesas, :color => "#B80000")
      end

      @percentual = Time.percentual_dia
      
      #RELATORIO 2 - PIE
      #RELATORIO DE GASTOS POR CATEGORIA
      @categorias = []
      @lancamentos_pizza = []
      @lancamentos.select("categoria_id, sum(valor) as valor").despesa.group("categoria_id").each do |l|
         @categorias << l.categoria.descricao

         lancamentos_sub = @lancamentos.select("sub_categoria_id, sum(valor) as valor").despesa.where(["categoria_id = ?", l.categoria_id]).group("sub_categoria_id").order('1 asc')
         percentual = ((l.valor*100)/ @totais[2]).to_f.round(2)

         sub_categorias = []
         lancamentos_sub.collect{|x| x.sub_categoria ? sub_categorias <<  x.sub_categoria.descricao : "" }
         sub_categorias << l.categoria.descricao if sub_categorias.blank?

         @lancamentos_pizza << { :categoria => l.categoria.descricao, 
                                 :y => percentual, 
                                 :subcategoria => sub_categorias,
                                 :data => lancamentos_sub.collect{|d| (d.valor*100/@totais[2]).round(2)}
                               }
      end
      
   
   end
end

