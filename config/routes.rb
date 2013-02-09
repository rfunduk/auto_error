AutoError::Engine.routes.draw do
  resources :app_errors
  root to: 'main#index'
end
