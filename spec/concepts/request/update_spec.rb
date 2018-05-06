require 'rails_helper'

describe Request::Update do
  let(:user) { create :user }
  let(:params) { { id: request.id, request: request_params } }
  let(:request) { create :request, user: user }
  let(:request_params) { { title: title, description: description } }
  let(:title) { Faker::Lorem.sentence }
  let(:description) { Faker::Lorem.paragraph }

  subject(:result) { fetch_operation }

  context 'with' do
    context 'policy that is' do
      shared_examples 'failure result' do
        it do
          is_expected.to be_failure
          expect(result['model'].status).to eq(request.status)
          expect(result['alerts']).to be_present
        end
      end

      context 'correct' do
        let(:params) { { id: request.id, request: request_params } }

        it { is_expected.to be_success }
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

        context 'wrong user' do
          let(:new_user) { create :user }
          let(:request) { create :request, user: new_user }

          it do
            is_expected.to be_failure
            expect(result['result.policy.default']).to be_failure
          end
        end
      end
    end

    context 'params that are' do
      shared_examples 'success result' do
        it do
          is_expected.to be_success
          expect(result['model'].title).to eq(title)
          expect(result['model'].description).to eq(description)
        end
      end

      shared_examples 'failure result' do |error_fields|
        it do
          is_expected.to be_failure
          expect(result['model'].title).not_to eq(title)
          expect(result['model'].description).not_to eq(description)
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

          it { is_expected.to be_failure }
        end

        context 'empty' do
          context 'title' do
            let(:title) { '' }

            it_behaves_like 'failure result', %i[title]
          end

          context 'description' do
            let(:description) { '' }

            it_behaves_like 'failure result', %i[description]
          end
        end

        context 'long title' do
          let(:title) { Faker::Lorem.sentence(500) }

          it_behaves_like 'failure result', %i[title]
        end
      end
    end

    context 'empty id in params' do
      let(:request) { instance_double(Request, id: '') }

      it { is_expected.to be_failure }
    end
  end
end
