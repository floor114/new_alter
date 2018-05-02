require 'rails_helper'

describe User::Index do
  let!(:user) { create :user }
  let!(:user1) { create :user, :administrator }
  let!(:user2) { create :user, :banned }
  let!(:user3) { create :user, :moderator }
  let!(:user4) { create :user, :volunteer }
  let!(:user5) { create :user, :newsmaker }
  let(:params) { {} }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    context 'correct' do

      it do
        is_expected.to be_success
        expect(result['model'].first).to eq(user2)
        expect(result['model']).not_to include(user)
        expect(result['model']).not_to include(user1)
        expect(result['model']).not_to include(user3)
        expect(result['model'].size).to eq(3)
      end
    end

    context 'not correct' do
      let(:user) { nil }

      it { is_expected.to be_failure }
    end
  end
end
