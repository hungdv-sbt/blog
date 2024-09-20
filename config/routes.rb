Rails.application.routes.draw do
  devise_for :users
  root 'post#index'
  # as :user do
  #   get "signin" => "devise/sessions#new"
  #   post "signin" => "devise/sessions#create"
  #   get "signout" => "devise/sessions#destroy"
  # end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :post
  get 'posts/list', to: 'post#posts_list', as: :posts_list
end
