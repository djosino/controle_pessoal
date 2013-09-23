json.array!(@rotinas) do |rotina|
  json.extract! rotina, :descricao, :data_vencimento, :data_pagamento, :categoria_id, :tipo_lancamento_id, :user_id, :valor, :data_inicial, :data_final, :ativo
  json.url rotina_url(rotina, format: :json)
end
