users = 2000.times.map do
  { email: Faker::Internet.unique.email, password: 'Woainvren1', password_confirmation: 'Woainvren1' }
end
User.create(users)
transfers = (2..2001).map do |num|
  { seller_id: num, player_id: User.find(num).players.first, price: 1000 }
end
Transfer.create(transfers)
