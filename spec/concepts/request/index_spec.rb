require 'rails_helper'

describe Request::Index do
  let(:user) { create :user }
  let(:params) { {} }
  let!(:request1) { create :request, :declined }
  let!(:request2) { create :request, :confirmed }
  let!(:request3) { create :request }
  let!(:request4) { create :request, :archived }
  let!(:request5) { create :request, :confirmed }

  subject(:result) { fetch_operation }

  it 'returns correct result' do
    is_expected.to be_success
    expect(result['model'].first).to eq(request5)
    expect(result['model'].size).to eq(2)
    expect(result['model']).not_to include(request1, request3, request4)
  end
end
