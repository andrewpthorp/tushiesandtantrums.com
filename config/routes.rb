TushiesandtantrumsCom::Application.routes.draw do

  # Basic Views
  root to: 'welcome#index'
  get '/about' => 'welcome#about', as: :about

  # Resources
  resources :products
end
