require 'rails_helper'

describe Decision::Create do
  let(:user) { create :user }
  let(:request_user) { create :user }
  let(:request) { create :request, user: request_user }
  let(:params) { { request_id: request.id, decision: decision_params } }
  let(:decision_params) { { description: description, accepted_items: accepted_items_params } }
  let(:description) { Faker::Lorem.paragraph }
  let(:accepted_items_params) { [accepted_item1_params, accepted_item2_params] }
  let(:required_item1) { create :required_item, request: request }
  let(:required_item2) { create :required_item, request: request }
  let(:required_item3) { create :required_item, request: request }
  let(:accepted_item1_params) { { required_item_id: required_item1.id, count: count1 } }
  let(:accepted_item2_params) { { required_item_id: required_item2.id, count: count2 } }
  let(:count1) { 66 }
  let(:count2) { 77 }

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
          expect(result['model'].accepted_items.pluck(:count)).to include(count1, count2)
          expect(result['model'].accepted_items.pluck(:required_item_id)).to include(required_item1.id, required_item2.id)
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
            let(:params) { { request_id: '', decision: {} } }

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

          context 'accepted items' do
            let(:accepted_items_params) { [] }

            it_behaves_like 'failure result', %i[accepted_items]
          end

          context 'some accepted item' do
            let(:accepted_item1_params) { { } }

            it_behaves_like 'failure result', %i[accepted_items.count accepted_items.required_item_id]
          end

          context 'accepted item' do
            context 'required item id' do
              let(:required_item1) { instance_double(RequiredItem, id: '') }

              it_behaves_like 'failure result', %i[accepted_items.required_item_id]
            end

            context 'count' do
              let(:count2) { '' }

              it_behaves_like 'failure result', %i[accepted_items.count]
            end
          end
        end

        context 'accepted item count not number' do
          let(:count1) { 'qwe' }

          it_behaves_like 'failure result', %i[accepted_items.count]
        end
      end
    end
  end
end
