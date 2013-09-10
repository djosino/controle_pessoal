# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u = User.new
u.email = 'admin@admin.com'
u.password = u.password_confirmation = '12345678'
u.save

User.all.each do |u|
   Categoria.create(:user_id => u.id, :descricao => "Pessoal")
   Categoria.create(:user_id => u.id, :descricao => "Receita")
   Categoria.create(:user_id => u.id, :descricao => "Salário")
   Categoria.create(:user_id => u.id, :descricao => "Moradia")
   Categoria.create(:user_id => u.id, :descricao => "Transporte")
   Categoria.create(:user_id => u.id, :descricao => "Alimentação")
   Categoria.create(:user_id => u.id, :descricao => "Despesas Bancárias")
end
