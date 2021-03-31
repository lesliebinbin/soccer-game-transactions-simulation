class Player < ApplicationRecord
  belongs_to :team

  def current_employer
    team.user
  end

  def brief_info
    "#{first_name} #{last_name}, position: #{position}, market_value: #{market_value}"
  end

end
