Rails.application.routes.draw do
  root 'toppage#toppage'
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
  }

  resources :groups do 
    member do
      patch 'change_approval_system'
    end
  end
  resources :join_groups

  resources :conversations do
    get :mail_box, on: :member
    resources :messages
  end

  resources :judgements, only: :create do 
    get :join_group_permission, on: :member
    get :join_group_deny, on: :member
  end 

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