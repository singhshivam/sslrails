Rails.application.routes.draw do
  get 'ssl/index'
  post 'ssl/test'

	root 'ssl#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
