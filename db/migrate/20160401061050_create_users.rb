class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :username
			t.string :password
			t.boolean :logged_in
			t.integer :update_count
			t.timestamps null: false
		end
	end
end
