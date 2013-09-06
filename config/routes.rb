TushiesandtantrumsCom::Application.routes.draw do

  # Basic Views
  root to: 'welcome#index'

  # Resources
  resources :products do
    collection do
      get 'boys', to: 'products#index', as: :boys, defaults: { category: 'boys' }
      get 'girls', to: 'products#index', as: :girls, defaults: { category: 'girls' }
    end
  end

  resources :inquiries, only: [:create]

  resources :charges, only: [:create] do
    collection do
      get 'new/product/:product_id', to: 'charges#new', as: :new_product
    end
  end

end
