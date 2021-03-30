class AddAdminUser < ActiveRecord::Migration[5.2]
  def change
    User.create! do |u|
      u.email = 'zhibin.huang@uqconnect.edu.au'
      u.password = 'Woainvren1'
      u.password_confirmation = 'Woainvren1'
      u.admin_role = true
    end
  end
end
