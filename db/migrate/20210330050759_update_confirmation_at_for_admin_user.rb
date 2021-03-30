class UpdateConfirmationAtForAdminUser < ActiveRecord::Migration[5.2]
  def change
    User.where(admin_role: true).update_all(confirmed_at: DateTime.now())
  end
end
