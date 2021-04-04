module Types
  class PlayerType < Types::BaseObject
    field :id, ID, null: false
    field :age, Integer, null: true
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :market_value, Float, null: true
    field :country, String, null: true
    field :team_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :position, String, null: true
    field :on_trade, Boolean, null: true
    field :full_name, String, null: false
    field :current_team, String, null: false
    field :team_country, String, null: false
    def current_team
      object.team.name
    end
    def team_country
      object.team.country
    end
  end
end
