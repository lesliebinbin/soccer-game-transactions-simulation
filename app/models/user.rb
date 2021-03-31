class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :team
  has_many :players, through: :team
  after_create :init_team_and_players
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         # :confirmable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  private

  def init_team_and_players
    return if admin_role?

    ActiveRecord::Base.transaction do
      player_count = Rails.configuration.game.dig(:settings, :player_positions).values.sum
      team_count = 1
      team, players = Generators::General.generate(team: team_count, player: player_count).values_at(:team, :player)
      create_team(team.first)
      self.team.players.create(players)
    end
  end
end
