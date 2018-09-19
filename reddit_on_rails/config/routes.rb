Rails.application.routes.draw do

  resources :users, only: [:new, :create]
  resource :session 
  resources :subs do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:index, :new, :create] do 
    resources :comments, only: [:create]
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :comments, except: [:create]
end
