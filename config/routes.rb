Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'post#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :post do
    collection do
      get 'list', to: 'post#my_posts'
    end
  end
end
