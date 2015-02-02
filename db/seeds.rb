# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
Book.delete_all
Book.create! id: 1, title: "Banana", price: 0.49, bookinstock: 1
Book.create! id: 2, title: "Apple", price: 0.29, bookinstock: 1
Book.create! id: 3, title: "Carton of Strawberries", price: 1.99, bookinstock: 1
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
