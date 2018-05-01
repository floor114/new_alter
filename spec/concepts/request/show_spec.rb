require 'rails_helper'

describe Request::Show do
  let(:user) { create :user }
  let(:params) { { id: request.id } }
  let(:request) { create :request, :confirmed }

  subject(:result) { fetch_operation }

  it 'returns correct result' do
    is_expected.to be_success
    expect(result['model']).to eq(request)
  end

  context 'without id in params' do
    let(:request) { instance_double(Request, id: '') }

    it { is_expected.to be_failure }
  end
end
