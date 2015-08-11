Rails.application.routes.draw do
  
  
  get 'users/show'

  devise_for :users
  resources :posts do
  	resources :comments do
      get 'like', on: :member
    end
  end

 match 'users/:id' => 'users#show', via: :get



  root "posts#index"

  get ':id' => 'users#show', as: :user_profile
  get ':id/setting' => 'users#edit', as: :user_setting
  get '/about', to: 'pages#about'
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash
  get "hashtags/:hashtag",   to: "posts#index",      as: :hashtag
  get "hashtags",            to: "hashtags#index",     as: :hashtags
  get "post/:id/likes", to: 'posts#likes', as: :likes

  match ':id/setting' => 'users#update', via: [:put, :patch]
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

end
