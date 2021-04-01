require 'rails_helper'

RSpec.describe 'Players', type: :request do
  fixtures :all
  describe 'GET /players' do
    it 'should be reject without login' do
      get players_path
      expect(response).to have_http_status(:unauthorized)
    end
    it 'return http success' do
      20.times.map { |num| "normal_user_#{num}".to_sym }.each do |user_sym|
        user = create(user_sym)
        sign_in user
        get players_path
        expect(response).to have_http_status(:success)
        sign_out user
      end
    end
  end
end
