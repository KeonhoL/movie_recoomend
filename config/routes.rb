Rails.application.routes.draw do
  get 'movie/list'

  get 'recommendation/action'

  get 'movie/list_category'
  
  get 'movie/list_complete'
  
  get 'movie/delete_complete/:id' => 'movie#delete_complete'
  
  get 'movie/delete_movie'

  get "movie/show/:id" => 'movie#show'
  
  post "movie/write_review_complete"
  
  get 'recommendation/index'
  
  get 'movie/delete_review_complete/:id' => 'movie#delete_review_complete'

  get 'movie/liked_complete/:id' => 'movie#liked_complete'
  
  get 'movie/liked_delete_complete/:id' => 'movie#liked_delete_complete'

  get "movie/edit/:id" => 'movie#edit'
  
  get "user/mypage/:id" => 'user#mypage'

  get 'movie/write'

  post 'movie/write_complete'

  get 'movie/edit'

  post 'movie/edit_complete'
  
  
  get 'movie/get_movie'

  get 'comments/create'

  get 'comments/destroy'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :bulletins do
    resources :posts
  end
  get 'home/index'
  get 'user/signup'
  post "user/signup_complete"
  get "user/login"
  post "user/login_complete"
  get "user/logout_complete"

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
