require 'rails_helper'

describe Decision::Show do
  let(:user) { create :user }
  let(:params) { { id: decision.id } }
  let(:decision) { create :decision, :created, request: request }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    context 'correct' do
      let(:request) { create :request, user: user }

      it do
        is_expected.to be_success
        expect(result['model']).to eq(decision)
        expect(result['model'].read?).to be_truthy
      end
    end

    context 'not correct' do
      let(:new_user) { create :user }
      let(:request) { create :request, user: new_user }

      it { is_expected.to be_failure }
    end
  end

  context 'without id in params' do
    let(:decision) { instance_double(Decision, id: '') }

    it { is_expected.to be_failure }
  end
end
