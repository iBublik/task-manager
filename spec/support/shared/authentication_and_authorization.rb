RSpec.shared_examples_for 'authable' do
  context 'unauthenticated' do
    let(:not_authenticated_message) { t('web.sessions.not_authenticated') }

    before { request }

    it { is_expected.to redirect_to sign_in_path }

    it { is_expected.to set_flash[:alert].to(not_authenticated_message) }
  end
end

RSpec.shared_examples_for 'authorizable' do
  context 'unauthorized' do
    let(:not_authorized_message) { t('web.sessions.not_authorized') }

    it { is_expected.to redirect_to root_path }

    it { is_expected.to set_flash[:alert].to(not_authorized_message) }
  end
end
