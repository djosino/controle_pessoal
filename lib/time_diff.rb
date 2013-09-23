class Time
   def self.diff(inicio, fim)
      qnt_dias_mes = []
      for i in inicio.month..fim.month
         data_i = Date.new(2013,i,1)
         data_f = data_i.end_of_month

         qnt_dias_mes << (data_f - data_i).to_i + 1
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
end