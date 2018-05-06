require 'rails_helper'

describe Decision::Index do
  let(:user) { create :user }
  let(:params) { {} }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    context 'correct' do
      let(:request) { create :request, :confirmed, user: user }
      let!(:decision1) { create :decision, :read, request: request }
      let!(:decision2) { create :decision, :created, request: request }
      let!(:decision3) { create :decision, :read, request: request }
      let!(:decision4) { create :decision, :created, request: request }
      let!(:decision5) { create :decision, :read }

      it do
        is_expected.to be_success
        expect(result['model'].first).to eq(decision4)
        expect(result['model']).not_to include(decision5)
        expect(result['model'].size).to eq(4)
      end
    end

    context 'not correct' do
      let(:user) { nil }

      it { is_expected.to be_failure }
    end
  end
end
