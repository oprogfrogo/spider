Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :users
  resources :homes
  resources :autos
  resources :agents
  resources :sessions
  resources :registrations
  resources :quotes

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

  get 'about' => 'welcome#about'
  get 'contact_us' => 'welcome#contact_us'
  get 'privay_policy' => 'welcome#privay_policy'
  get 'claims' => 'welcome#claims'
  get 'homes' => 'homes#new'
  get 'approve_home_request' => 'homes#approve_home_request'
  get 'agent_login' => 'agents#login'
  get 'agent_logout' => 'agents#logout'
  get 'session_logout' => 'sessions#logout'
  get 'agent_homes' => 'agents#homes'
  get 'agent_autos' => 'agents#autos'
  get 'confirm_email' => 'registrations#confirm_email'

  post 'store_zip' => 'welcome#store_zip'
  post 'send_quote' => 'quotes#send_quote'
  post 'home_insurance_quote' => 'welcome#home_insurance_quote'
  post 'agent_auth' => 'agents#auth'
  post 'user_login' => 'users#login'
  post 'users_check_exist' => 'users#users_check_exist'
end
