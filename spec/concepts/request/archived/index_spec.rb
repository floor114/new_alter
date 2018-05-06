require 'rails_helper'

describe Request::Archived::Index do
  let(:user) { create :user }
  let(:params) { {} }
  let!(:request1) { create :request, :archived, user: user }
  let!(:request2) { create :request, :archived, user: user }
  let!(:request3) { create :request, :archived }
  let!(:request4) { create :request, :confirmed, user: user }
  let!(:request5) { create :request, :unconfirmed, user: user }
  let!(:request6) { create :request, :declined, user: user }

  subject(:result) { fetch_operation }

  context 'when user id is' do
    context 'present' do
      before { request1.update(updated_at: Time.zone.now + 5.minutes) }

      let(:params) { { user_id: user.id } }

      it do
        is_expected.to be_success
        expect(result['model'].first).to eq(request1)
        expect(result['model']).not_to include(request3)
        expect(result['model'].size).to eq(2)
      end
    end

    context 'not present' do
      it do
        is_expected.to be_success
        expect(result['model'].first).to eq(request3)
        expect(result['model'].size).to eq(3)
      end
    end
  end
end
