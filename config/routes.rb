Rails.application.routes.draw do
  devise_for :users

  root 'activities#index'
  resources :activities do
    patch :finish
    patch :resume
    get :tags, on: :collection
  end

  resource :smartwatch do
    get :activities
    get :analytics
    patch :finish
    patch :resume
    patch :start_activity
  end

  get '/analytics' => 'analytics#index'
  get '/change_layout' => 'smartwatches#change_layout'
end

