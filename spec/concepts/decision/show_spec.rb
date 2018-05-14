require 'rails_helper'

describe Decision::Show do
  let(:user) { create :user }
  let(:params) { { id: decision.id } }
  let(:decision) { create :decision, request: request }
  let(:request) { create :request, user: user }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    shared_examples 'failure result' do
      it do
        is_expected.to be_failure
        expect(result['model'].status).to eq(decision.status)
        expect(result['alerts']).to be_present
      end
    end

    context 'correct' do
      it do
        is_expected.to be_success
        expect(result['model']).to eq(decision)
        expect(result['model'].status).to eq(Decision::READ)
        expect(result['model'].read?).to be_truthy
      end
    end

    context 'not correct because of ' do
      context 'user' do
        let(:new_user) { create :user }
        let(:request) { create :request, user: new_user }

        it_behaves_like 'failure result'
      end

      context 'accepted decision' do
        let(:decision) { create :decision, :accepted, request: request }

        it_behaves_like 'failure result'
      end

      context 'partly accepted decision' do
        let(:decision) { create :decision, :partly_accepted, request: request }

        it_behaves_like 'failure result'
      end

      context 'rejected decision' do
        let(:decision) { create :decision, :rejected, request: request }

        it_behaves_like 'failure result'
      end
    end
  end

  context 'without id in params' do
    let(:decision) { instance_double(Decision, id: '') }

    it { is_expected.to be_failure }
  end
end
