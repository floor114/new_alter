require 'rails_helper'

describe Request::Archive do
  let(:user) { create :user }
  let(:params) { { id: request.id } }
  let(:request) { create :request, :confirmed, user: user }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    shared_examples 'success result' do
      it do
        is_expected.to be_success
        expect(result['model'].status).to eq(Request::ARCHIVED)
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

    context 'correct because of confirmed request and' do
      context 'same user' do
        it_behaves_like 'success result'
      end

      context 'user as administrator' do
        let(:user) { create :user, :administrator }

        it_behaves_like 'success result'
      end

      context 'user as moderator' do
        let(:user) { create :user, :moderator }

        it_behaves_like 'success result'
      end
    end

    context 'not correct because of' do
      context 'unconfirmed request' do
        let(:request) { create :request, user: user }

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

      context 'wrong user' do
        let(:new_user) { create :user }
        let(:request) { create :request, :declined, user: new_user }

        it_behaves_like 'failure result'
      end
    end
  end

  context 'without id in params' do
    let(:request) { instance_double(Request, id: '') }

    it { is_expected.to be_failure }
  end
end
