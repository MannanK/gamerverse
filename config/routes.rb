Rails.application.routes.draw do
  get '/register' => 'register#index'
  post 'register/create' => 'register#create'
  
  get '/login' => 'login#index'
  post '/login' => 'login#create'
  get '/logout' => 'login#logout'
  
  get '/profile' => 'profile#index'
  get '/profile/edit' => 'profile#edit'
  post '/profile/edit' => 'profile#submit'
  
  get '/events' => 'events#index'
  get '/events/create' => 'events#create'
  post '/events/create' => 'events#submit'
  
  #post '/events/favorite' => 'events#favorite'
  resources :events do
    put :favorite, on: :member
  end
  
  #post '/games/favorite' => 'games#favorite'
  resources :games do
    put :favorite, on: :member
  end
  #resources :events
  
  
  get 'homepage/index'
  root 'homepage#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
