Rails.application.routes.draw do
  devise_for :users

  root 'activities#index'
  resources :activities do
    patch 'finish'
    get :tags, on: :collection
  end

  get '/analytics' => 'analytics#index'
end
