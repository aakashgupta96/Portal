Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "user/registrations", sessions: "user/sessions", confirmations: "user/confirmations", passwords: "user/passwords", :omniauth_callbacks => "user/omniauth_callbacks"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"


  get '/dashboard' => 'users#dashboard', as: "dashboard"

  root 'users#direct_root'

  scope :users do
    get ':username' => 'users#profile', as: "show_profile"
  end


  scope :projects do
    get '/taken' => 'projects#taken' , as: "taken_projects"
    get '/bidded' => 'projects#bidded', as: "bidded_projects"
    get '/completed' => 'projects#completed', as: "completed_projects"
    get '/posted' => 'projects#posted', as: "posted_projects"
  end



  #get 'skills/:skill', to: 'projects#index', as: :skills
  resources :projects do
      get :autocomplete_tag_name, :on => :collection
  end
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
  #   en

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
  get "*path" => redirect('/')
  
end
