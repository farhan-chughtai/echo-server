Rails.application.routes.draw do
  resources :endpoints
  match '*path', :to => 'echos#page', :via => [:get, :post, :patch, :put, :delete]
end
