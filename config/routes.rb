Soso::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :language_grades

  get 'profile/password'
  get 'faculties/field_of_studies/:faculty_id', to: 'faculties#field_of_studies', as: :faculties_field_of_studies
  get 'faculties/specializations/:field_of_study_id', to: 'faculties#specializations', as: :faculties_specializations

  resources :faqs do
    collection do
      post 'sort'
    end
  end

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

  resources :users do
    resources :subject_grades do
      collection do
        post 'sort'
        get 'edit'
      end
    end
    resources :language_grades do
      collection do
        post 'enroll', to: 'users#create', as: :enroll
        patch 'lock', as: :lock
        get 'skip', as: :skip

        # staff
        get 'payment'
        patch 'pay'
      end
    end
    resources :exams do
      collection do
        patch 'lock', as: :lock
      end
      member do
        patch 'sign_up'
        patch 'release'
      end
    end
    patch 'lock', to: 'users#lock', as: :data_lock
    patch 'unlock', to: 'users#unlock', as: :data_unlock

    # staff
    patch :confirm_grades, as: :confirm_grades
    patch :disapprove_grades, as: :disapprove_grades
  end

  get 'p/:slug', to: 'pages#show', as: :page
end
