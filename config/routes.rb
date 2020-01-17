Rails.application.routes.draw do
  root 'toppage#toppage'
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
  }

  resources :groups do 
    member do
      patch 'change_approve_system'
    end
  end
  resources :join_groups 

  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
  # get "signup", :to => "users/registrations#new"
  # get "login", :to => "users/sessions#new"
  # get "logout", :to => "users/sessions#destroy"
  end


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end