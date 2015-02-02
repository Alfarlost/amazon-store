class AddNewAdmin < ActiveRecord::Migration
	def data
  	  Admin.create (email: "alfarlost@yandex.ru", password: "zaqwer12")
    end
end
