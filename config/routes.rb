Rails.application.routes.draw do
  root "home#index"
  
  get 'dashboard', to: 'dashboard#index'
  
  resources :study_sessions, only: [:show, :create] do
    member do
      post :answer
    end
  end
end
