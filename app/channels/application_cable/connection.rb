module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    def connect
      reject_unauthorized_connection unless signed_in?
    end
  end
end
