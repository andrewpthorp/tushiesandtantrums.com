TushiesandtantrumsCom::Application.routes.draw do

  # Public: For more information on single user systems, visit the devise wiki
  # on GitHub.
  devise_for :admins, skip: :registrations

  # Public: Root route for the website.
  root to: 'welcome#index'

  # Public: Routes for Products.
  resources :products, only: [:index, :show] do
    collection do

      # Public: Route used to view boys Products.
      #
      # Examples
      #
      #   boys_products_path
      #   # => '/products/index?category=boys'
      get 'boys', to: 'products#index', as: :boys, defaults: { category: 'boys' }

      # Public: Route used to view boys Products.
      #
      # Examples
      #
      #   girls_products_path
      #   # => '/products/index?category=girls'
      get 'girls', to: 'products#index', as: :girls, defaults: { category: 'girls' }
    end
  end

  # Public: Routes for Inquiries.
  resources :inquiries, only: [:new, :create]

  # Public: Routes for Charges.
  resources :charges, only: [:create] do
    collection do

      # Public: Route used to create a new Charge.
      #
      # Examples
      #
      #   new_product_charges_path(Product.first)
      #   # => '/charges/new/product/product-slug'
      get 'new/product/:product_id', to: 'charges#new', as: :new_product
    end
  end

  # Public: Admin routes.
  namespace :admin do

    # Public: Admin routes for Products.
    resources :products, except: [:show]

    # Public: Admin routes for Charges.
    resources :charges, only: [:index, :show, :update]

    # Public: Admin routes for Inquiries.
    resources :inquiries, only: [:index, :show, :destroy]
  end

end
