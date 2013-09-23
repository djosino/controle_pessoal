class ApplicationController < ActionController::Base
  require Rails.root + "lib/time_diff.rb"
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :get_notifications
  before_action :executar_rotinas
  

  def get_notifications
  	@notificacoes = []
  end

   def executar_rotinas
      if current_user and current_user.rotinas.count > 0
         # Executar rotinas pendentes
         current_user.rotinas.where("(ultima_execucao_em = current_date or ultima_execucao_em is null) and ativo is true").each do |r|
            dev_criados = Time.diff(r.data_inicial, Date.today)
            max_criados = Time.diff(r.data_inicial, r.data_final)
            criados = r.lancamentos.count
            dev_criados = max_criados if dev_criados > max_criados
            dif = dev_criados - criados
            if r.data_inicial <= Date.today and criados == 0
               data = r.data_inicial
               Lancamento.create(:valor              => r.valor, 
                                 :user_id            => r.user_id,
                                 :descricao          => r.descricao, 
                                 :rotina_id          => r.id, 
                                 :data_pagamento     => data, 
                                 :data_vencimento    => data, 
                                 :categoria_id       => r.categoria_id, 
                                 :tipo_lancamento_id => r.tipo_lancamento_id )
            end
            if dev_criados > criados 
               for i in 1..dif
                  ultimo = r.lancamentos.first
                  if !ultimo
                     data = r.data_inicial
                  else
                     data = ultimo.data_pagamento + 1.month
                  end
                  Lancamento.create(:valor              => r.valor, 
                                    :user_id            => r.user_id,
                                    :descricao          => r.descricao, 
                                    :rotina_id          => r.id, 
                                    :data_pagamento     => data, 
                                    :data_vencimento    => data, 
                                    :categoria_id       => r.categoria_id, 
                                    :tipo_lancamento_id => r.tipo_lancamento_id )
               end
            end   
            r.ultima_execucao_em = Date.today
            r.save
         end
      end
   end
end