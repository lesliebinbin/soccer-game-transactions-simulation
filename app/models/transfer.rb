class Transfer < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  belongs_to :buyer, class_name: 'User', optional: true
  belongs_to :player
  default_scope { where(buyer: nil) }
  scope :done, -> { where.not(buyer: nil) }
  before_destroy { logger.info 'Leslie is so handsome!' }
end
