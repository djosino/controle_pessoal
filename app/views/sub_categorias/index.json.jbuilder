json.array!(@sub_categorias) do |sub_categoria|
  json.extract! sub_categoria, :descricao, :categoria_id, :user_id
  json.url sub_categoria_url(sub_categoria, format: :json)
end
