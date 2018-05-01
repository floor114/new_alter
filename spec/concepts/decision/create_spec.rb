require 'rails_helper'

describe Decision::Create do
  let(:user) { create :user }
  let(:request_user) { create :user }
  let(:request) { create :request, user: request_user }
  let(:params) { { request_id: request.id, decision: decision_params } }
  let(:decision_params) { { description: description } }
  let(:description) { Faker::Lorem.paragraph }

  subject(:result) { fetch_operation }

  context 'with' do
    context 'policy that is' do
      shared_examples 'success result' do
        it do
          is_expected.to be_success
          expect(result['alerts']).to be_present
        end
      end

      shared_examples 'failure result' do
        it do
          is_expected.to be_failure
          expect(result['result.policy.default']).to be_failure
        end
      end

      context 'correct' do
        it_behaves_like 'success result'

        context 'and some other decisions are present' do
          let!(:decision1) { create :decision, :created, user: user }
          let!(:decision2) { create :decision, :accepted, user: user }

          it_behaves_like 'success result'
        end
      end

      context 'not correct because of' do
        context 'wrong user' do
          let(:user) { request_user }

          it_behaves_like 'failure result'
        end

        context 'not ended decisions' do
          let!(:decision1) { create :decision, request: request, user: user }

          it_behaves_like 'failure result'
        end
      end
    end

    context 'params that are' do
      shared_examples 'success result' do
        it do
          is_expected.to be_success
          expect(result['model']).to be_persisted
          expect(result['model'].description).to eq(description)
          expect(result['model'].request).to eq(request)
          expect(result['model'].user).to eq(user)
          expect(result['alerts']).to be_present
        end
      end

      shared_examples 'failure result' do |error_fields|
        it do
          is_expected.to be_failure
          expect(result['model']).to be_new_record
          expect(result['alerts']).to be_present
          expect(result['contract.default'].errors.messages).to include(*error_fields) if error_fields
        end
      end

      context 'correct' do
        it_behaves_like 'success result'
      end

      context 'not correct because of' do
        context 'presence' do
          let(:params) { {} }

          it_behaves_like 'failure result'
        end

        context 'empty' do
          context 'request id' do
            let(:request) { instance_double(Request, id: '') }

            it_behaves_like 'failure result', %i[request]
          end

          context 'decision params' do
            let(:decision_params) { {} }

            it_behaves_like 'failure result', %i[description]
          end

          context 'description' do
            let(:description) { '' }

            it_behaves_like 'failure result', %i[description]
          end
        end
      end
    end
  end
end
