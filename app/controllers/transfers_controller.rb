class TransfersController < ApplicationController
  def new
    @transfer = Transfer.new
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
        format.json { render json: { errors: t.errors } }
      end
    end
  end

  def search
    # search_field, search_value = search_params.values_at(:field, :value)
    render json: Transfer.all
    # respond_to do |format|
    #   # format.json { render json: Transfers.search(search_field, search_value) }
    #   format.json {
    #     render json: Transfer.all
    #   }
    # end
  end

  private

  def create_transfer_params
    params.require(:transfer).permit(:seller, :player, :price)
  end

  def search_params
    params.require(:search_term).permit(:field, :value)
  end
end
