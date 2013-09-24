class Time
   def self.diff(inicio, fim)
      qnt_dias_mes = []
      for i in inicio.month..fim.month
         data_i = Date.new(2013,i,1)
         data_f = data_i.end_of_month

         qnt_dias_mes << data_f.day
      end

      diff = (fim - inicio).to_i
      meses = 0

      qnt_dias_mes.each do |mes|
         diff = diff - mes
         if diff >= 0
            meses += 1
         else
            return meses
         end
      end
      return meses
   end

   def self.percentual_dia
      hoje = Date.today
      fim_mes = hoje.end_of_month.day

      return ((hoje.day * 100) / fim_mes).to_i
   end
end