require 'rails_helper'

RSpec.describe Web::DashboardController, type: :controller do
  describe 'GET #index' do
    let(:tasks) { create_pair(:task) }

    before { get :index }

    it 'sets collection of all tasks' do
      expect(assigns(:tasks)).to match_array(tasks)
    end

    it { is_expected.to render_template :index }
  end
end
