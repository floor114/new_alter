require 'rails_helper'

describe Decision::PartlyAccept do
  let(:user) { create :user }
  let(:params) { { id: decision.id, decision: decision_params } }
  let(:request) { create :request, user: user}
  let(:decision) { create :decision, request: request }
  let(:decision_params) { { accepted_items: accepted_items_params } }
  let(:accepted_items_params) { [accepted_item1_params, accepted_item2_params] }
  let(:accepted_item1) { create :accepted_item, decision: decision, count: count1 }
  let(:accepted_item2) { create :accepted_item, decision: decision, count: count2 }
  let(:accepted_item3) { create :accepted_item, decision: decision }
  let(:accepted_item1_params) { { id: accepted_item1.id, helped_count: helped_count1 } }
  let(:accepted_item2_params) { { id: accepted_item2.id, helped_count: helped_count2 } }
  let(:helped_count1) { 66 }
  let(:count1) { 100 }
  let(:helped_count2) { 77 }
  let(:count2) { 200 }

  subject(:result) { fetch_operation }

  context 'with' do
    context 'policy that is' do
      shared_examples 'policy success result' do
        it do
          is_expected.to be_success
          expect(result['model'].status).to eq(Decision::PARTLY_ACCEPTED)
          expect(result['alerts']).to be_present
        end
      end

      shared_examples 'policy failure result' do
        it do
          is_expected.to be_failure
          expect(result['model'].status).to eq(decision.status)
          expect(result['alerts']).to be_present
        end
      end

      context 'correct because of same request user and' do
        context 'created decision' do
          it_behaves_like 'policy success result'
        end

        context 'read decision' do
          let(:decision) { create :decision, :read, request: request }

          it_behaves_like 'policy success result'
        end
      end

      context 'not correct because of' do
        context 'user' do
          let(:new_user) { create :user }
          let(:request) { create :request, user: new_user }

          it_behaves_like 'policy failure result'
        end

        context 'accepted decision' do
          let(:decision) { create :decision, :accepted, request: request }

          it_behaves_like 'policy failure result'
        end

        context 'partly accepted decision' do
          let(:decision) { create :decision, :partly_accepted, request: request }

          it_behaves_like 'policy failure result'
        end

        context 'rejected decision' do
          let(:decision) { create :decision, :rejected, request: request }

          it_behaves_like 'policy failure result'
        end
      end
    end

    context 'params that are' do
      shared_examples 'params success result' do
        it do
          is_expected.to be_success
          expect(result['model'].status).to eq(Decision::PARTLY_ACCEPTED)
          expect(result['model'].accepted_items.pluck(:helped_count)).to include(helped_count1, helped_count2)
        end
      end

      shared_examples 'params failure result' do |error_fields|
        it do
          is_expected.to be_failure
          expect(result['model'].status).to eq(decision.status)
          expect(result['alerts']).to be_present
          expect(result['contract.default'].errors.messages).to include(*error_fields) if error_fields
        end
      end

      context 'correct' do
        it_behaves_like 'params success result'
      end

      context 'not correct because of' do
        context 'empty' do
          context 'decision params' do
            let(:decision_params) { {} }

            it_behaves_like 'params failure result', %i[accepted_items]
          end

          context 'accepted items' do
            let(:accepted_items_params) { [] }

            it_behaves_like 'params failure result', %i[accepted_items]
          end

          context 'accepted item' do
            context 'helped count' do
              let(:helped_count2) { '' }

              it_behaves_like 'params failure result', %i[accepted_items.helped_count]
            end
          end
        end

        context 'accepted item helped count'  do
          context 'not number' do
            let(:helped_count1) { 'qwe' }

            it_behaves_like 'params failure result', %i[accepted_items.helped_count]
          end

          context 'greater than count' do
            let(:helped_count1) { count1 + 200 }

            it_behaves_like 'params failure result', %i[accepted_items.helped_count]
          end
        end
      end
    end

    context 'accepted items as unacceptable' do
      let(:accepted_item1_params) {
        {
          id: accepted_item1.id,
          helped_count: helped_count1,
          _destroy: AcceptedItem::Contract::PartlyAccept::DESTROY_MARK
        }
      }

      it do
        is_expected.to be_success
        expect(result['model'].accepted_items.size).to eq(2)
        expect(result['model'].accepted_items.pluck(:helped_count)).to include(helped_count2, ::AcceptedItem::ZERO_HELP)
      end
    end
  end

  context 'without id in params' do
    let(:params) { { id: '' } }

    it { is_expected.to be_failure }
  end
end
