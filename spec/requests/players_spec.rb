require 'rails_helper'

RSpec.describe 'Players', type: :request do
  20.times.map { |num| "normal_user_#{num}".to_sym }.each do |user_sym|
    let(:user) { create(user_sym) }
    it 'should be reject access unless login' do
      get players_path
      expect(response).to have_http_status(:unauthorized)
      put player_path(user.players.first)
      expect(response).to have_http_status(:unauthorized)
    end
    let(:first_user) { create(:normal_user_1) }
    let(:second_user) { create(:normal_user_2) }
    it "should reject modifying other user's player" do
      sign_in first_user
      player = second_user.players.first
      put player_path(player, player: { country: 'Italy' })
      expect(response).to have_http_status(:unauthorized)
      sign_out first_user
    end
    it 'should only able to update country first_name and last_name' do
      sign_in first_user
      player = first_user.players.first
      put player_path(player, player: { country: 'Italy' })
      expect(response).to have_http_status(:success)
      put player_path(player, player: { first_name: 'Hello' })
      expect(response).to have_http_status(:success)
      put player_path(player, player: { last_name: 'World' })
      expect(response).to have_http_status(:success)
      put player_path(player, player: { country: 'Australia', first_name: 'Rails', last_name: 'Sinatra' })
      expect(response).to have_http_status(:success)
      previous_updated_at = player.updated_at
      # invalid params should not update the player
      put player_path(player, player: { hello: 'World' })
      expect(previous_updated_at).to eq(player.updated_at)
      sign_out first_user
    end
  end
end
