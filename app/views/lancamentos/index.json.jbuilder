json.array!(@lancamentos) do |lancamento|
  json.extract! lancamento, :data_vencimento, :data_pagamento, :valor, :tipo_lancamento_id, :categoria_id, :user_id
  json.url lancamento_url(lancamento, format: :json)
end
