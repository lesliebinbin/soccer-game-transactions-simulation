require 'rails_helper'

RSpec.describe 'Transfers', type: :request do
  let(:u1) { create(:normal_user_1) }
  let(:u2) { create(:normal_user_2) }
  let(:u3) { create(:normal_user_3) }
  it 'should reject access unless login' do
    get transfers_path
    expect(response).to have_http_status(:unauthorized)
    sign_in u1
    get transfers_path
    expect(response).to have_http_status(:success)
    sign_out u1
  end
  # it 'should be able to trade his own player only once' do
  #   sign_in u1
  #   player = u1.players.first
  #   headers = { 'ACCEPT' => 'application/json' }
  #   post transfers_path, params: { transfer: { seller: u1.id, player: player.id, price: 1000 } }, headers: headers
  #   expect(response).to have_http_status(:success)
  #   post transfers_path, params: { transfer: { seller: u1.id, player: player.id, price: 1000 } }, headers: headers
  #   expect(response).to have_http_status(:not_acceptable)
  # end

  it 'should affect buyer, seller and player once trasaction succeed' do
    sign_in u1
    seller_id = u1.id
    player = u1.players.first
    budget_u1 = u1.budget
    budget_u2 = u2.budget
    market_value_before_trade = player.market_value
    headers = { 'ACCEPT' => 'application/json' }
    post transfers_path, params: { transfer: { seller: u1.id, player: player.id, price: 1000 } }, headers: headers
    expect(response).to have_http_status(:success)
    expect(Transfer.last.seller_id).to eq(u1.id)
    player.reload
    expect(player.on_trade?).to be true
    sign_out u1
    sign_in u2
    put purchase_transfer_path(Transfer.last)
    expect(response).to have_http_status(:success)
    player.reload
    u1.reload
    u2.reload
    expect(player.on_trade?).to be false
    expect(player.current_employer.id).to eq(u2.id)
    expect(u1.budget).to be > budget_u1
    expect(u2.budget).to be < budget_u2
    expect(player.market_value).to be_between(market_value_before_trade * 1.1, market_value_before_trade * 2)
    sign_out u2
  end
end
