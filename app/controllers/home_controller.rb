class HomeController < ApplicationController

  def consultas
      @anos = []
      for i in 2013..Date.today.year
         @anos << i
      end
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

      for i in @inicial..@final
         dias << i.day 
         despesas << @lancamentos.despesa.collect{|l| l.data_pagamento == i ? l.valor : 0.0 }.sum
         receitas << @lancamentos.receita.collect{|l| l.data_pagamento == i ? l.valor : 0.0 }.sum
      end

      @chart = LazyHighCharts::HighChart.new('line') do |f|
         f.title({ :text=>"Relatório Mensal"})
         f.options[:xAxis][:categories] = dias 
         f.options[:yAxis][:title][:text] = "Valores"
         f.series(:type=> 'column', :name => "Receitas", :data => receitas)
         f.series(:type=> 'column', :name => "Despesas", :data => despesas, :color => "#B80000")
      end

      @percentual = Time.percentual_dia
      
      #RELATORIO 2 - PIE
      #RELATORIO DE GASTOS POR CATEGORIA
      @lancamentos_pizza = []
      @lancamentos.select("categoria_id, sum(valor) as valor").despesa.group("categoria_id").each do |l|
         percentual = ((l.valor) / @totais[2])
         @lancamentos_pizza << [l.categoria.descricao, percentual.to_f.round(2)]
      end
      

      @chart_pizza = LazyHighCharts::HighChart.new('pie') do |f|
            f.chart({:defaultSeriesType=>"pie" , :margin=> [20, 60, 20, 60]} )
            series = {
                     :type=> 'pie',
                     :name=> 'Browser share',
                     :data=> @lancamentos_pizza
            }
            f.series(series)
            f.options[:title][:text] = "Lançamentos por Categoria"
            f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
            f.plot_options(:pie=>{
              :allowPointSelect=>true, 
              :cursor=>"pointer" , 
              :dataLabels=>{
                :enabled=>true,
                :color=>"black",
                :style=>{
                  :font=>"13px Trebuchet MS, Verdana, sans-serif"
                }
              }
            })
      end
   end
end
