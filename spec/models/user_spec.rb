require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Normal User' do
    20.times.map { |num| "normal_user_#{num}".to_sym }.each do |user_sym|
      let(:user) { create(user_sym) }
      scenario 'should have 5000 budget' do
        expect(user.budget).to eq(5000)
      end
      scenario 'should have a team' do
        expect(user.team).not_to be_nil
        expect(user.team)
      end

      scenario 'should have 20 players' do
        expect(user.players.count).to eq(20)
      end
      scenario 'each player worth 1000 initially' do
        user.players.each do |p|
          expect(p.market_value).to eq(1000)
        end
      end
    end
  end
end
