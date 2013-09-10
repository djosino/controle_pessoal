json.array!(@categoria) do |categorium|
  json.extract! categorium, :user_id, :descricao
  json.url categorium_url(categorium, format: :json)
end
