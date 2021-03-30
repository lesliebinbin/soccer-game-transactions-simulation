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
      team, players = Generators::General.generate(team: 1, player: 20).values_at(:team, :player)
      create_team(team.first)
      self.team.players.create(players)
    end
  end
end
