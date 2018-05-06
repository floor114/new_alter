require 'rails_helper'

describe Request::Confirm do
  let(:user) { create :user, :administrator }
  let(:params) { { id: request.id } }
  let(:request) { create :request, :unconfirmed, user: user }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    shared_examples 'success result' do
      it do
        is_expected.to be_success
        expect(result['model'].status).to eq(Request::CONFIRMED)
        expect(result['alerts']).to be_present
      end
    end

    shared_examples 'failure result' do
      it do
        is_expected.to be_failure
        expect(result['model'].status).to eq(request.status)
        expect(result['alerts']).to be_present
      end
    end

    context 'correct because of unconfirmed request and' do
      context 'user as administrator' do
        it_behaves_like 'success result'
      end

      context 'user as moderator' do
        let(:user) { create :user, :moderator }

        it_behaves_like 'success result'
      end
    end

    context 'not correct because of' do
      context 'confirmed request' do
        let(:request) { create :request, :confirmed, user: user }

        it_behaves_like 'failure result'
      end

      context 'archived request' do
        let(:request) { create :request, :archived, user: user }

        it_behaves_like 'failure result'
      end

      context 'declined request' do
        let(:request) { create :request, :declined, user: user }

        it_behaves_like 'failure result'
      end

      context 'user without privileges' do
        let(:user) { create :user, :volunteer }

        it_behaves_like 'failure result'
      end
    end
  end

  context 'without id in params' do
    let(:request) { instance_double(Request, id: '') }

    it { is_expected.to be_failure }
  end
end
