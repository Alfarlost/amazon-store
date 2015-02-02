class AddNewAdmin1 < ActiveRecord::Migration
	def data
  	  admin = Admin.new
  	  admin.name = "Alfar"
  	  admin.email = "alfarlost@yandex.ru"
  	  admin.password = "zaqwer12"
  	  admin.save
    end
end
