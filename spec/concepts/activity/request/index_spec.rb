require 'rails_helper'

describe Activity::Request::Index do
  let(:user) { create :user }
  let(:params) { { request_id: request.id } }
  let(:request) { create :request, :confirmed }
  let!(:request_activity1) { create :request_activity, trackable: request }
  let!(:request_activity2) { create :request_activity, trackable: request }
  let!(:request_activity3) { create :request_activity }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    context 'correct' do

      it do
        is_expected.to be_success
        expect(result['model'].first).to eq(request_activity2)
        expect(result['model'].size).to eq(2)
        expect(result['model']).not_to include(request_activity3)
      end
    end

    context 'not correct' do
      let(:user) { nil }

      it { is_expected.to be_failure }
    end
  end
end
