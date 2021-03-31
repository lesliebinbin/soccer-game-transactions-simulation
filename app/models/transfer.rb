class Transfer < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  belongs_to :buyer, class_name: 'User', optional: true
  belongs_to :player
  default_scope { where(buyer: nil) }
  scope :done, -> { where.not(buyer: nil) }
  after_save { broadcasts_to 'home' }

  def processing_the_transfer
    ActiveRecord::Base.transaction do
      seller.team.delete(player)
      buyer.team.players << player
      update_the_values
      buyer.save
      seller.save
      player.save
    end
  end

  private

  def update_the_values
    buyer.budget -= trading_price
    seller.budget += trading_price
    player.market_value = trading_price
  end
end
