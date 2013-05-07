require 'sidekiq/web'
Sepap2::Application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'
  
  scope "/:locale", :defaults => {:locale => "en"}, :locale => /en|es/ do
    devise_for :users

    root :to => 'home#index'
    
    resources :topics
    resources :assignments , only: :index do
      resources :problems, only: :show do
        resources :attempts, only: :create
      end
    end

    resources :problems, only:[:index,:show] do
      resources :attempts, only: :create
      get :use_toolkit, on: :member
    end
    
    
    # Admin Namespace and resources for admin.
    namespace :admin do
      resources :problems do
        put :toggle_active
      end
      resources :subjects, path: "courses"
      resources :topics, except: :show
      resources :users
      resources :commands
    end
    
    # Teacher Namespace and resources for teacher.
    namespace :teacher do
      resources :groups do
        resources :assignments, except: :index do
          member do
            get :compare
          end
        end
      end
      resources :problems, except:[:edit, :update, :destroy]
    end
  end

  # Routes for the judge results
  post '/admin/problems/judge_results'
  post '/attempts/judge_results'
  post '/problems/judge_results'
  post '/varch/:group_id/:assignment_id' => 'teacher/assignments#varch_results'

  match '/:locale/users' => 'home#index'
  match '/:locale' => 'home#index'
  get '/' => 'home#index'

end
