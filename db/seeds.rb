# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
Book.delete_all
Book.create! id: 1, title: "Banana", price: 0.49, bookinstock: 1, category_id: 1, description: "lksdhgljdfhsgkjhdfgherihgrdguhdfkghdfkjjfkjdgkjdfhgkjdfkjghkjdfhgkjldfhgkjhdfkjghldfkhgkldfhgkjhdfkjlghkjdfhgkldfhgkjlhdfkjghlkdfhgkljdfhgkjldfhkghdfklghkdfjlhgkjldfhgkjdfhlkjghdfkghkdjfhgkjdfhgkjhdkjghdkfhgkjldfhgklhdfklghdfklhgldkhglkdfhgldh"
Book.create! id: 5, title: "Banana", price: 0.49, bookinstock: 1, category_id: 1, description: "lksdhgljdfhsgkjhdfgherihgrdguhdfkghdfkjjfkjdgkjdfhgkjdfkjghkjdfhgkjldfhgkjhdfkjghldfkhgkldfhgkjhdfkjlghkjdfhgkldfhgkjlhdfkjghlkdfhgkljdfhgkjldfhkghdfklghkdfjlhgkjldfhgkjdfhlkjghdfkghkdjfhgkjdfhgkjhdkjghdkfhgkjldfhgklhdfklghdfklhgldkhglkdfhgldh"
Book.create! id: 6, title: "Banana", price: 0.49, bookinstock: 1, category_id: 1, description: "lksdhgljdfhsgkjhdfgherihgrdguhdfkghdfkjjfkjdgkjdfhgkjdfkjghkjdfhgkjldfhgkjhdfkjghldfkhgkldfhgkjhdfkjlghkjdfhgkldfhgkjlhdfkjghlkdfhgkljdfhgkjldfhkghdfklghkdfjlhgkjldfhgkjdfhlkjghdfkghkdjfhgkjdfhgkjhdkjghdkfhgkjldfhgklhdfklghdfklhgldkhglkdfhgldh"
Book.create! id: 4, title: "Banana", price: 0.49, bookinstock: 1, category_id: 1, description: "lksdhgljdfhsgkjhdfgherihgrdguhdfkghdfkjjfkjdgkjdfhgkjdfkjghkjdfhgkjldfhgkjhdfkjghldfkhgkldfhgkjhdfkjlghkjdfhgkldfhgkjlhdfkjghlkdfhgkljdfhgkjldfhkghdfklghkdfjlhgkjldfhgkjdfhlkjghdfkghkdjfhgkjdfhgkjhdkjghdkfhgkjldfhgklhdfklghdfklhgldkhglkdfhgldh"
Book.create! id: 2, title: "Apple", price: 0.29, bookinstock: 1, category_id: 2, description: "lksdhgljdfhsgkjhdfgherihgrdguhdfkghdfkjjfkjdgkjdfhgkjdfkjghkjdfhgkjldfhgkjhdfkjghldfkhgkldfhgkjhdfkjlghkjdfhgkldfhgkjlhdfkjghlkdfhgkljdfhgkjldfhkghdfklghkdfjlhgkjldfhgkjdfhlkjghdfkghkdjfhgkjdfhgkjhdkjghdkfhgkjldfhgklhdfklghdfklhgldkhglkdfhgldh"
Book.create! id: 3, title: "Carton of Strawberries", price: 1.99, bookinstock: 1, category_id: 3, description: "lksdhgljdfhsgkjhdfgherihgrdguhdfkghdfkjjfkjdgkjdfhgkjdfkjghkjdfhgkjldfhgkjhdfkjghldfkhgkldfhgkjhdfkjlghkjdfhgkldfhgkjlhdfkjghlkdfhgkljdfhgkjldfhkghdfklghkdfjlhgkjldfhgkjdfhlkjghdfkghkdjfhgkjdfhgkjhdkjghdkfhgkjldfhgklhdfklghdfklhgldkhglkdfhgldh"
Discount.create! id: 1, coupone_code: "DISK", discount: 0.5

Category.delete_all
Category.create! id: 1, title: "Banans"
Category.create! id: 2, title: "Apples"
Category.create! id: 3, title: "Cartons"
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
