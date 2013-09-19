# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if User.count == 0
   u = User.new
   u.email = 'admin@admin.com'
   u.password = u.password_confirmation = '12345678'
   u.save
end

if Categoria.count == 0
   Categoria.create(:descricao => "Salário",                 :tipo_lancamento_id => 1)
end

User.all.each do |u|
   if u.categorias.blank?
      Categoria.create(:user_id => u.id, :descricao => "Pessoal",                 :tipo_lancamento_id => 2)
      Categoria.create(:user_id => u.id, :descricao => "Transporte - Manutenção", :tipo_lancamento_id => 2)
      Categoria.create(:user_id => u.id, :descricao => "Transporte - Gasolina",   :tipo_lancamento_id => 2)
      Categoria.create(:user_id => u.id, :descricao => "Alimentação",             :tipo_lancamento_id => 2)
      Categoria.create(:user_id => u.id, :descricao => "Despesas Bancárias",      :tipo_lancamento_id => 2)
   end
end
