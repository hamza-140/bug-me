Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '*path', to: 'errors#not_found', via: :all
  root to: 'projects#index'
  get '/projects/bugs', to: 'projects#bugs'
  resources :projects do
    resources :bugs
  end
end
