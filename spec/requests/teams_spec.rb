require 'rails_helper'

RSpec.describe 'Teams', type: :request do
  let(:user) { create(:normal_user_2) }
  it 'should reject access unless sign in' do
    get team_path
    expect(response).to have_http_status(:unauthorized)
    sign_in user
    get team_path
    expect(response).to have_http_status(:success)
    sign_out user
  end
  it 'should reject modification unless sign in' do
    put(team_path(team: { country: 'Australia', name: "I don't know" }))
    expect(response).to have_http_status(:unauthorized)
    sign_in user
    put(team_path(team: { country: 'Australia', name: "I don't know" }))
    expect(response).to have_http_status(:success)
    sign_out user
  end
end
