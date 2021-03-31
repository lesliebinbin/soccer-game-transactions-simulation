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

  def buy_player(transfer)
    return if transfer.seller_id == id || transfer.price > budget || transfer.buyer_id

    ActiveRecord::Base.transaction do
      player = Player.find(transfer.player_id)
      seller = User.find(transfer.seller_id)
      update_the_values(transfer.price, self, seller, player)
      transfer.buyer_id = id
      transfer.save!
    end
  end

  private

  def update_the_values(trading_price, buyer, seller, player)
    player.team_id = buyer.team.id
    buyer.budget -= trading_price
    seller.budget += trading_price
    player.market_value = trading_price
    buyer.save
    seller.save
    buyer.team.save
    seller.team.save
    player.save!
  end

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
