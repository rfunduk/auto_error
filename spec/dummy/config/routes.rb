Rails.application.routes.draw do
  resource :error_faker
  resources :sessions
  get '/logout' => 'sessions#destroy'
  mount AutoError::Engine => "/auto_error"
  root to: 'main#index'
end
