require 'rails_helper'

describe Request::Create do
  let(:user) { create :user }
  let(:params) { { request: request_params } }
  let(:request_params) {
    {
      title: title,
      description: description,
      required_items: required_items_params
    }
  }
  let(:title) { Faker::Lorem.sentence }
  let(:description) { Faker::Lorem.paragraph }
  let(:required_items_params) { [required_item1_params, required_item2_params] }
  let(:required_item1_params) { { category_id: category1.id, goal: goal1 } }
  let(:required_item2_params) { { category_id: category2.id, goal: goal2 } }
  let(:goal1) { 666 }
  let(:goal2) { 777 }
  let(:category1) { create :category }
  let(:category2) { create :category }

  subject(:result) { fetch_operation }

  context 'with' do
    context 'policy that is' do
      context 'correct' do
        it { is_expected.to be_success }
      end

      context 'not correct because of' do
        context 'empty user' do
          let(:user) { nil }

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
          expect(result['model']).to be_persisted
          expect(result['model'].title).to eq(title)
          expect(result['model'].description).to eq(description)
          expect(result['model'].user).to eq(user)
          expect(result['model'].required_items.pluck(:goal)).to include(goal1, goal2)
          expect(result['model'].required_items.pluck(:category_id)).to include(category1.id, category2.id)
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
          context 'request params' do
            let(:request_params) { {} }

            it_behaves_like 'failure result', %i[title description]
          end

          context 'title' do
            let(:title) { '' }

            it_behaves_like 'failure result', %i[title]
          end

          context 'description' do
            let(:description) { '' }

            it_behaves_like 'failure result', %i[description]
          end

          context 'required items' do
            let(:required_items_params) { [] }

            it_behaves_like 'failure result', %i[required_items]
          end

          context 'some required item' do
            let(:required_item1_params) { { } }

            it_behaves_like 'failure result', %i[required_items.goal required_items.category_id]
          end

          context 'required item' do
            context 'category id' do
              let(:category1) { instance_double(Category, id: '') }

              it_behaves_like 'failure result', %i[required_items.category_id]
            end

            context 'goal' do
              let(:goal2) { '' }

              it_behaves_like 'failure result', %i[required_items.goal]
            end
          end
        end

        context 'required item goal not number' do
          let(:goal1) { 'qwe' }

          it_behaves_like 'failure result', %i[required_items.goal]
        end

        context 'long title' do
          let(:title) { Faker::Lorem.sentence(500) }

          it_behaves_like 'failure result', %i[title]
        end
      end
    end
  end
end
