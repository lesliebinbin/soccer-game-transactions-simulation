class TransfersController < ApplicationController
  before_action :check_access
  def index
    query = %q(
      {
  transactions {
    id
    price
    player {
      country
      age
      marketValue
      fullName
      currentTeam
      teamCountry
    }
  }
}
    )
    render json: SoccerGameSchema.execute(query)
  end

  def new
    @transfer = Transfer.new
  end

  def update
    head :unauthorized unless current_user.admin_role? || t.check_seller?(current_user)
  end

  def purchase
    current_user.buy_player(Transfer.find(params[:id]))
    head :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :not_acceptable
  end

  def create
    seller_id, player_id, price = create_transfer_params.values_at(:seller, :player, :price)
    seller_id = seller_id.to_i
    player_id = player_id.to_i
    price = price.to_f

    return unless seller_id.to_i == current_user.id

    t = Transfer.new(seller_id: seller_id, player_id: player_id, price: price)
    respond_to do |format|
      if t.save
        format.html { redirect_to root_path, notice: 'Transfer successfully created!' }
        format.json { render json: { notice: 'Transfer successfully created!' } }
      else
        format.html { redirect_to root_path, alert: t.errors }
        format.json { render json: { errors: t.errors }, status: :not_acceptable }
      end
    end
  end

  def search
    field, value = search_params.values_at(:search_field, :search_value)
    render json: Transfer.search(field, value) || []
  end

  private

  def create_transfer_params
    params.require(:transfer).permit(:seller, :player, :price)
  end

  def search_params
    params.permit(:search_field, :search_value)
  end
end
