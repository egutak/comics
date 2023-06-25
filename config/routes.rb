Rails.application.routes.draw do

  root to: 'public/homes#top'
  get "/about" => "public/homes#about", as: "about"

  devise_for :users,skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#new_guest'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
  }

  namespace :public do
    get :searches, to: 'searches#searches'
    resources :books do
     resource :favorites, only: [:index, :create, :destroy]
     resources :comments, only: [:create, :destroy]
    end
    patch '/books/:id' => 'books#update'
    resources :users, except: [:show, :edit, :update]
    get '/users/my_page' => 'users#show'
    get '/users/information/edit' => 'users#edit'
    patch '/users/information' => 'users#update'
    get '/users/unsubscribe' => 'users#unsubscribe'
    patch '/users/withdraw' => 'users#withdraw'
  end

  namespace :admin do
    get '/' => 'homes#top'
    resources :comments
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
