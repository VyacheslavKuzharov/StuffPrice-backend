Rails.application.routes.draw do

  root 'welcome#index'
  devise_for :users, controllers: { registrations: 'api/users/registrations', sessions: 'api/users/sessions', passwords: 'api/users/passwords' }

  namespace :api, defaults: { format: :json } do
    resources :products
  end
end
