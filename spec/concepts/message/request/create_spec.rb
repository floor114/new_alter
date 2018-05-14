require 'rails_helper'

describe Message::Request::Create do
  let(:user) { create :user }
  let(:request_user) { create :user }
  let(:request) { create :request, :confirmed, user: request_user }
  let(:params) { { request_id: request.id, message: message_params } }
  let(:message_params) { { body: body } }
  let(:body) { Faker::Lorem.paragraph }

  subject(:result) { fetch_operation }

  context 'with' do
    context 'policy that is' do
      shared_examples 'failure result' do
        it do
          is_expected.to be_failure
          expect(result['result.policy.default']).to be_failure
        end
      end

      context 'correct' do
        it { is_expected.to be_success }
      end

      context 'not correct because of' do
        context 'missing user' do
          let(:user) { nil }

          it_behaves_like 'failure result'
        end

        context 'receiver not request' do
          let(:request) { instance_double(Request, id: '') }

          it_behaves_like 'failure result'
        end

        context 'not confirmed request' do
          let(:request) { create :request, user: request_user }

          it_behaves_like 'failure result'
        end
      end
    end

    context 'params that are' do
      shared_examples 'failure result' do |error_fields|
        it do
          is_expected.to be_failure
          expect(result['model']).to be_new_record
          expect(result['alerts']).to be_present
          expect(result['contract.default'].errors.messages).to include(*error_fields) if error_fields
        end
      end

      context 'correct' do
        it do
          is_expected.to be_success
          expect(result['model']).to be_persisted
          expect(result['model'].body).to eq(body)
        end
      end

      context 'not correct because of' do
        context 'presence' do
          let(:message_params) { {} }

          it_behaves_like 'failure result'
        end

        context 'empty body' do
          let(:message_params) { { body: '' } }

          it_behaves_like 'failure result', %i[body]
        end
      end
    end
  end
end
