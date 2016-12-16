# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |x|
	User.create(username: "awesomeBackpackers#{x}", email: "backpacker#{x}@gmail.com", password:"password", password_confirmation: "password")
end
p "Test users created"

categories=Category.create([{name:'Backpacks'},{name:'Tents'},{name:'Maps'},{name:'Books'},{name:'Cookware'},{name:'Misc'}])
p"Categories seeded"