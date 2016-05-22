Rails.application.routes.draw do

  root 'welcome#index'
  devise_for :users

  namespace :api, defaults: { format: :json } do
    resources :products, controller: '/products'

  end
end
