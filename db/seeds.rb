users = 20.times.map do
  { email: Faker::Internet.unique.email, password: 'goandguess123', password_confirmation: 'goandguess123' }
end
User.create(users)
transfers = (2..21).map do |num|
  { seller_id: num, player_id: User.find(num).players.first.id, price: 1000 }
end
Transfer.create!(transfers)
