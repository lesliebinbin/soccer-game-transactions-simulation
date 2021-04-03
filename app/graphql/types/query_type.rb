module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :transactions, [Types::TransferType], null: false, description: "current ongoing transfers" do
      argument :filter_field, String, required: false
      argument :filter_value, String, required: false
    end

    field :transaction, Types::TransferType, null: false do
      argument :tid, Integer, required: true
    end

    def transaction(tid:)
      Transfer.find(tid)
    end
    
    def transactions(filter_field: nil, filter_value: nil)
      if filter_field.nil?
        Transfer.all
      else
        Transfer.search(filter_field, filter_value)
      end
    end

  end
end
