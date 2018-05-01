require 'rails_helper'

describe Request::Find do
  let(:user) { create :user }
  let(:params) { { id: request.id } }

  subject(:result) { fetch_operation }

  context 'with id that is' do
    context 'correct' do
      let(:request) { create :request }

      it do
        is_expected.to be_success
        expect(result['model']).to eq request
      end
    end

    context 'not correct' do
      let(:request) { instance_double(Request, id: '') }

      it { is_expected.to be_failure }
    end
  end
end
