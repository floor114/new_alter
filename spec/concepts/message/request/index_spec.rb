require 'rails_helper'

describe Message::Request::Index do
  let(:user) { create :user }
  let(:params) { { request_id: request.id } }
  let(:request) { create :request, :confirmed }
  let!(:message1) { create :request_message, receiver: request }
  let!(:message2) { create :request_message, receiver: request }
  let!(:message3) { create :request_message }

  subject(:result) { fetch_operation }

  it 'returns correct result' do
    is_expected.to be_success
    expect(result['model'].first).to eq(message2)
    expect(result['model'].size).to eq(2)
    expect(result['model']).not_to include(message3)
  end
end
