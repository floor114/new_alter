require 'rails_helper'

describe User::Show do
  let(:user) { create :user }
  let(:some_user) { create :user }
  let(:params) { { id: some_user.id } }

  subject(:result) { fetch_operation }

  context 'with policy that is' do
    context 'correct' do
      it do
        is_expected.to be_success
        expect(result['model']).to eq(some_user)
      end
    end

    context 'not correct' do
      let(:user) { nil }

      it { is_expected.to be_failure }
    end
  end

  context 'without id in params' do
    let(:some_user) { instance_double(User, id: '') }

    it { is_expected.to be_failure }
  end
end
