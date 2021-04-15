Rails.application.routes.draw do
  # get 'repositories/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :repositories, only: %i[index show]
  root to: 'repositories#index'
end
