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
  resources :quotes_home
  resources :quotes_auto

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
  get 'agent_homes' => 'agents#homes'
  get 'agent_autos' => 'agents#autos'

  get 'client_login' => 'sessions#create'
  get 'session_logout' => 'sessions#logout'

  get 'confirm_email' => 'registrations#confirm_email'
  get 'resend_confirmation_email' => 'registrations#resend_confirmation_email'

  get 'quotes_auto' => 'quotes#auto'
  get 'quotes_home' => 'quotes#home'
  get 'edit_auto' => 'quotes#edit_auto'
  get 'edit_home' => 'quotes#edit_home'

  get 'edit_quotes_auto' => 'quotes_auto#edit'
  get 'edit_quotes_home' => 'quotes_home#edit'

  get 'draw_quote_auto' => 'agents#draw_quote_auto'
  get 'resend_quote_auto' => 'agents#resend_quote_auto'

  get 'draw_quote_home' => 'agents#draw_quote_home'
  get 'resend_quote_home' => 'agents#resend_quote_home'

  post 'store_zip' => 'welcome#store_zip'
  post 'home_insurance_quote' => 'welcome#home_insurance_quote'
  post 'contact_us' => 'welcome#contact_us'

  post 'send_quote_home' => 'quotes_home#send_quote_home'
  post 'send_quote_auto' => 'quotes_auto#send_quote_auto'

  post 'user_login' => 'users#login'
  post 'users_check_exist' => 'users#users_check_exist'

  post 'agent_auth' => 'agents#auth'
end
