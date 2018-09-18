Rails.application.routes.draw do
  get 'posts/edit'
  get 'subs/new'
  get 'subs/index'
  get 'subs/show'
  get 'subs/edit'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/new'
  get 'users/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
