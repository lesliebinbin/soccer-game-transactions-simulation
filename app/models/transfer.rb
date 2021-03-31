class Transfer < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  belongs_to :buyer, class_name: 'User', optional: true
  belongs_to :player
  default_scope { where(buyer: nil) }
  scope :done, -> { where.not(buyer: nil) }
  after_create do
    player.update(on_trade: true)
    TransactionPublishJob.perform_later
  end
  after_update do
    player.update(on_trade: false) unless buyer.nil?
    TransactionPublishJob.perform_later
  end
end
