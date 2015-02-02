class AddNewAdmin2 < ActiveRecord::Migration
  	def up
  	  Admin.create(email: "alfarlost@yandex.ru", password: "zaqwer12")
    end
end
