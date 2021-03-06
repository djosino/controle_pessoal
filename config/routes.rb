ControlePessoal::Application.routes.draw do
  
  resources :sub_categorias do
    collection do
      post :categoria
    end
  end

  resources :rotinas

  resources :categorias do
    collection do
      post :por_tipo
    end
  end

  resources :lancamentos do
    collection do
      get :receitas
      get :despesas
    end
  end

  devise_for :users, :path_names => { 
                :sign_in => 'login', 
                :sign_out => 'logout', 
                :password => 'secret', 
                :confirmation => 'verification', 
                :unlock => 'unblock', 
                :registration => 'register', 
                :sign_up => 'cmon_let_me_in' 
             }


  resources :home, :only => [:index] do
    collection do
      get :consultas, :por_mes_ano
      post :por_mes_ano
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  constraints(User) do
      authenticated :user do
         root to: "home#index", as: :authenticated_root
      end
      unauthenticated do
         root to: "users#login", as: :unauthenticated_root
     end
  end

  root "home#index"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
