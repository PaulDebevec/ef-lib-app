Rails.application.routes.draw do
  root 'users#index'
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  resources :users do
    collection do
      get :list, :customer
      get :report 
    end
  end
  
  resources :books do
    collection do
      get :list
      post :returned, :import
      get  :review
    end
    member do
      patch :deliver
    end
  end
end
