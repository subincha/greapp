class AddPasswordDigestToAdminUsers < ActiveRecord::Migration
	def up
		remove_column "admin_users", "password"
		add_column "admin_users", "password_digest", :string
	end

	def down
		add_column "admin_users", "password"
		remove_column "admin_users", "password_digest"
	end
end
