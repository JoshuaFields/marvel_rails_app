Rails.application.routes.draw do
  root 'characters#show'

  resources :characters
end
