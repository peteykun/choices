Rails.application.routes.draw do
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

  root 'quizzes#show'

  namespace :admin do
    root 'questions#index'
    
    resources :questions
    resources :users

    get 'settings', to: 'settings#index'
    post 'settings', to: 'settings#update'
    
    get 'leaderboard', to: 'users#leaderboard'
    get 'game_manager', to: 'game_manager#index'
    get 'game_manager/:action', to: 'game_manager'
  end

  resource  :quiz
  resources :answers
  resources :sessions
  resources :users

  get 'login',    to: 'sessions#new'
  get 'register', to: 'users#new'
  get 'logout',   to: 'sessions#destroy'
  get 'lobby',    to: 'static_pages#lobby'
  get 'complete', to: 'static_pages#complete'

end
