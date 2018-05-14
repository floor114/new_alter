require 'rails_helper'

describe Message::Request::Destroy do
  let(:user) { create :user }
  let(:params) { { id: message.id } }
  let(:request) { create :request, :confirmed }
  let(:message) { create :request_message, receiver: request, user: user }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    shared_examples 'failure result' do
      it do
        is_expected.to be_failure
        expect(result['model']).not_to be_destroyed
        expect(result['alerts']).to be_present
      end
    end

    context 'correct' do
      it do
        is_expected.to be_success
        expect(result['model']).to be_destroyed
      end
    end

    context 'not correct because of' do
      context 'receiver not request' do
        let(:message) { create :request_message, receiver_id: user.id, receiver_type: User.name }

        it_behaves_like 'failure result'
      end

      context 'wrong user' do
        let(:new_user) { create :user }
        let(:message) { create :request_message, receiver: request, user: new_user }

        it_behaves_like 'failure result'
      end
    end
  end

  context 'without id in params' do
    let(:params) { { id: '' } }

    it { is_expected.to be_failure }
  end
end
