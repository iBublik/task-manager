Rails.application.routes.draw do
  scope module: :web do
    root 'dashboard#index'

    get 'sign_in', to: 'sessions#new', as: :sign_in
    resource :session, only: [:create, :destroy]

    scope module: :account do
      resources :tasks
    end
  end
end
