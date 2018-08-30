require 'rails_helper'

describe Settings::ExportsController do
  render_views

  describe 'GET #show' do
    context 'when signed in' do
      let(:user) { Fabricate(:user) }

      before do
        sign_in user, scope: :user
      end

      it 'renders export' do
        get :show

        export = assigns(:export)
        expect(export).to be_instance_of Export
        expect(export.account).to eq user.account
        expect(response).to have_http_status(200)
      end
    end

    context 'when not signed in' do
      it 'redirects' do
        get :show
        expect(response).to redirect_to '/auth/sign_in'
      end
    end
  end
end
