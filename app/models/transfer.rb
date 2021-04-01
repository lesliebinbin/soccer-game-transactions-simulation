class Transfer < ApplicationRecord
  validates :price, numericality: { greater_than: 0 }
  belongs_to :seller, class_name: 'User'
  belongs_to :buyer, class_name: 'User', optional: true
  belongs_to :player
  has_one :team, through: :player
  default_scope { where(buyer: nil) }
  scope :done, -> { where.not(buyer: nil) }
  validates_uniqueness_of :player, conditions: -> { where(buyer: nil) }
  after_create do
    player.update(on_trade: true)
    TransactionPublishJob.perform_later
  end
  after_update do
    player.update(on_trade: false) unless buyer.nil?
    TransactionPublishJob.perform_later
  end

  def self.search(field, value)
    case field
    when 'team_country'
      joins(:team).where('teams.country like ?', "%#{value}%")
    when 'team_name'
      joins(:team).where('teams.name like ?', "%#{value}%")
    when 'player_name'
      joins(:player).where("CONCAT(players.first_name,' ' ,players.last_name) like ?", "%#{value}%")
    when 'market_value'
      joins(:player).where(players: { market_value: Typecasts::General.cast_to_number(value) })
    when 'trading_price'
      where(price: Typecasts::General.cast_to_number(value))
    else
      []
    end
  end

  def check_seller?(user)
    user.id == seller.id
  end

  def as_json(_options = {})
    {
      t_id: id,
      team_country: player.team.country,
      team_name: player.team.name,
      player_name: player.full_name,
      market_value: player.market_value.to_f,
      trading_price: price.to_f
    }
  end
end
