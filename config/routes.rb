TushiesandtantrumsCom::Application.routes.draw do

  devise_for :admins

  # Basic Views
  root to: 'welcome#index'

  # Resources
  resources :products, only: [:index, :show] do
    collection do
      get 'boys', to: 'products#index', as: :boys, defaults: { category: 'boys' }
      get 'girls', to: 'products#index', as: :girls, defaults: { category: 'girls' }
    end
  end

  resources :inquiries, only: [:new, :create]

  resources :charges, only: [:create] do
    collection do
      get 'new/product/:product_id', to: 'charges#new', as: :new_product
    end
  end

  # Admin Routes
  namespace :admin do
    resources :products, except: [:show]
    resources :charges, only: [:index, :show, :update]
  end

end
