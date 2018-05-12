require 'rails_helper'

describe Request::Update do
  let(:user) { create :user }
  let(:params) { { id: request.id, request: request_params } }
  let(:request) { create :request, user: user }
  let(:request_params) {
    {
      title: title,
      description: description,
      required_items: required_items_params
    }
  }
  let(:title) { Faker::Lorem.sentence }
  let(:description) { Faker::Lorem.paragraph }
  let(:required_item1) { create :required_item, request: request }
  let(:required_item2) { create :required_item, request: request }
  let(:required_items_params) { [required_item1_params, required_item2_params] }
  let(:required_item1_params) { { id: required_item1.id, category_id: category1.id, goal: goal1 } }
  let(:required_item2_params) { { id: required_item2.id, category_id: category2.id, goal: goal2 } }
  let(:goal1) { 666 }
  let(:goal2) { 777 }
  let(:category1) { create :category }
  let(:category2) { create :category }

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

          ri1 = result['model'].required_items.find(required_item1.id)
          expect(ri1.category).to eq(category1)
          expect(ri1.goal).to eq(goal1)

          ri2 = result['model'].required_items.find(required_item2.id)
          expect(ri2.category).to eq(category2)
          expect(ri2.goal).to eq(goal2)
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

          context 'required items' do
            let(:required_items_params) { [] }

            it_behaves_like 'failure result', %i[required_items]
          end

          context 'some required item' do
            let(:required_item1_params) { { id: required_item1.id, goal: '', category_id: '' } }

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

    context 'required items to delete' do
      let(:required_item1_params) {
        {
          id: required_item1.id,
          category_id: category1.id,
          goal: goal1,
          _destroy: Request::Contract::Create::DESTROY_MARK
        }
      }

      it do
        is_expected.to be_success
        expect(result['model'].required_items.size).to eq(1)
      end
    end

    context 'empty id in params' do
      let(:params) { { id: '' } }

      it { is_expected.to be_failure }
    end
  end
end
