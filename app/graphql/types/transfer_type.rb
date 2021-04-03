module Types
  class TransferType < Types::BaseObject
    field :id, ID, null: false
    field :price, Float, null: true
    field :player, Types::PlayerType, null: false
    field :team_country, String, null: false

    def team_country
      object.player.team.country
    end
  end
end
