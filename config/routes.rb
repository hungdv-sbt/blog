Rails.application.routes.draw do
  devise_for :users

  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    get "signout" => "devise/sessions#destroy"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'post#index'
  get '/posts/new', to: 'post#new'
  post 'posts/new', to: 'post#create'
end
