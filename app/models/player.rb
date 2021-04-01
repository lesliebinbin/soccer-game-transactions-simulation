class Player < ApplicationRecord
  belongs_to :team
  scope :not_on_trade, -> { where(on_trade: false) }

  def current_employer
    team.user
  end

  def brief_info
    "full_name #{full_name}, position: #{position}, market_value: #{market_value}"
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
