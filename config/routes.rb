Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'post#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :post
  get 'posts/list', to: 'post#posts_list', as: :posts_list
end
