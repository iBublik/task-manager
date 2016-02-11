require 'rails_helper'

RSpec.describe Web::SessionsController, type: :controller do
  shared_examples_for 'redirection for signed in user' do
    let(:signed_in_message) { t('web.sessions.already_signed_in') }

    context 'with signed in user' do
      before do
        sign_in
        request
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it { is_expected.to set_flash[:alert].to(signed_in_message) }
    end
  end

  shared_examples_for 'succefull action' do
    it { is_expected.to redirect_to root_path }

    it { is_expected.to set_flash[:notice].to(success_message) }
  end

  describe 'GET #new' do
    context 'with not signed in user' do
      before { get :new }

      it { is_expected.to render_template :new }
    end

    it_behaves_like 'redirection for signed in user' do
      let(:request) { get :new }
    end
  end

  describe 'POST #create' do
    context 'with not signed in user' do
      let(:user_credentials) { { email: 'john.doe@example.com', password: 'qwerty123' } }
      let!(:user) { create(:user, user_credentials) }

      context 'with valid credentials' do
        before { post :create, session: user_credentials }

        it_behaves_like 'succefull action' do
          let(:success_message) { t('web.sessions.create.success') }
        end

        it { is_expected.to set_session[:user_id].to(user.id) }
      end

      context 'with invalid credentials' do
        let(:invalid_credentials) { { email: 'john.doe@example.com', password: '321ytrewq' } }

        let(:fail_message) { t('web.sessions.create.fail') }

        before { post :create, session: invalid_credentials }

        it { is_expected.to render_template :new }

        it { is_expected.to set_flash.now[:alert].to(fail_message) }

        it { is_expected.not_to set_session[:user_id] }
      end
    end

    it_behaves_like 'redirection for signed in user' do
      let(:request) { post :create }
    end
  end

  describe 'DELETE #destroy' do
    context 'with signed in user' do
      before do
        sign_in
        delete :destroy
      end

      it_behaves_like 'succefull action' do
        let(:success_message) { t('web.sessions.destroy.success') }
      end

      it 'removes user id fron session' do
        expect(session[:user_id]).to be_nil
      end
    end

    context 'with not signed in user' do
      let(:not_signed_in_message) { t('web.sessions.not_signed_in') }

      before { delete :destroy }

      it { is_expected.to redirect_to root_path }

      it { is_expected.to set_flash[:alert].to(not_signed_in_message) }
    end
  end
end
