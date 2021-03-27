module Generators::General
  def generate(args)
    args.map do |k, v|
      generated_value = (0...v).map { |_k, _v| send(k) }
      generated_value = attach_positions_to_players(generated_value) if k == :player
      [k, generated_value]
    end.to_h
  end

  def player
    min_age, max_age = Rails.application.config.game.dig(:settings, :player, :age).values_at(:min, :max)
    { first_name: Faker::Name.male_first_name, last_name: Faker::Name.last_name,
      age: rand(min_age..max_age),
      market_value: Rails.application.config.game.dig(:settings, :player, :market_value),
      country: Faker::Address.country }
  end

  def team
    { name: Faker::Team.name, country: Faker::Address.country }
  end

  def attach_positions_to_players(players)
    positions = Rails.application.config.game.dig(:settings, :player_positions)
    positions = positions.map do |k, v|
      [k] * v
    end.flatten
    players.zip(positions).map do |player, position|
      player.merge({ position: position.to_s })
    end
  end
end
