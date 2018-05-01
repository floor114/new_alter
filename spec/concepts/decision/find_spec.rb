require 'rails_helper'

describe Decision::Find do
  let(:user) { create :user }
  let(:params) { { id: decision.id } }

  subject(:result) { fetch_operation }

  context 'with id that is' do
    context 'correct' do
      let(:decision) { create :decision }

      it do
        is_expected.to be_success
        expect(result['model']).to eq(decision)
      end
    end

    context 'not correct' do
      let(:decision) { instance_double(Decision, id: '') }

      it { is_expected.to be_failure }
    end
  end
end
