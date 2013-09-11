json.array!(@categorias) do |categoria|
  json.extract! categoria, :user_id, :descricao
  json.url categoria_url(categoria, format: :json)
end
