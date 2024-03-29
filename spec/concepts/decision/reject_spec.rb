require 'rails_helper'

describe Decision::Reject do
  let(:user) { create :user }
  let(:params) { { id: decision.id } }
  let(:decision) { create :decision, request: request }
  let!(:accepted_item1) { create :accepted_item, decision: decision }
  let!(:accepted_item2) { create :accepted_item, decision: decision }
  let(:request) { create :request, user: user }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    shared_examples 'success result' do
      it do
        is_expected.to be_success
        expect(result['model'].status).to eq(Decision::REJECTED)
        expect(result['model'].accepted_items.first.helped_count).to eq(::AcceptedItem::ZERO_HELP)
        expect(result['model'].accepted_items.second.helped_count).to eq(::AcceptedItem::ZERO_HELP)
        expect(result['alerts']).to be_present
      end
    end

    shared_examples 'failure result' do
      it do
        is_expected.to be_failure
        expect(result['model'].status).to eq(decision.status)
        expect(result['model'].accepted_items.first.helped_count).to be_nil
        expect(result['model'].accepted_items.second.helped_count).to be_nil
        expect(result['alerts']).to be_present
      end
    end

    context 'correct because of same request user and' do
      context 'created decision' do
        it_behaves_like 'success result'
      end

      context 'read decision' do
        let(:decision) { create :decision, :read, request: request }

        it_behaves_like 'success result'
      end
    end

    context 'not correct because of' do
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
    let(:params) { { id: '' } }

    it { is_expected.to be_failure }
  end
end
