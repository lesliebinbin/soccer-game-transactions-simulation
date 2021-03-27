class Player < ApplicationRecord
  belongs_to :team

  def current_employer
    team.user
  end
end
