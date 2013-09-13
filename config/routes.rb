Soso::Application.routes.draw do
  resources :language_grades

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  get 'profile' => 'profile#show'
  patch 'profile/edit' => 'profile#update'
  get 'profile/edit'
  get 'profile/password'
  get 'faculties/field_of_studies/:faculty_id', to: 'faculties#field_of_studies', as: :faculties_field_of_studies
  get 'faculties/specializations/:field_of_study_id', to: 'faculties#specializations', as: :faculties_specializations

  resource :profile do
    resources :subject_grades do
      collection do
        post 'sort'
      end
    end
    resources :language_grades do
      collection do
        post 'enroll', to: 'profile#create', as: :enroll
      end
    end
    patch 'lock', to: 'profile#lock', as: :lock
    patch 'unlock', to: 'profile#unlock', as: :unlock

    get 'skip_exam', to: 'profile#skip_exam', as: :skip_exam
  end

  resources :faqs do
    collection do
      post 'sort'
    end
  end

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

  root to: 'pages#root'

  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
             only: [:new, :create, :edit, :update],
             path: 'users',
             path_names: {new: 'sign_up'},
             controller: 'devise/registrations',
             as: :user_registration do
      get :cancel
    end
  end

  resources :users

  get 'p/:slug', to: 'pages#show', as: :page
end
