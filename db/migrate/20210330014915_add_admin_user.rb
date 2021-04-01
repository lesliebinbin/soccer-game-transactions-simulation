class AddAdminUser < ActiveRecord::Migration[5.2]
  def change
    User.create! do |u|
      u.email = 'myexample@example.com'
      u.password = 'goandguess123'
      u.password_confirmation = 'goandguess123'
      u.admin_role = true
    end
  end
end
