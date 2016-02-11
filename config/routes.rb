Rails.application.routes.draw do
  scope module: :web do
    root 'dashboard#index'

    get 'sign_in', to: 'sessions#new', as: :sign_in
    resource :session, only: [:create, :destroy]

    scope module: :account do
      resources :tasks do
        patch :switch_state, on: :member, defaults: { format: :json }
      end
    end
  end
end
