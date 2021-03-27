class User < ApplicationRecord
  has_one :team
  has_many :players , through: :team
end
