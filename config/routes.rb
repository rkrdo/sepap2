Sepap2::Application.routes.draw do
  scope "/:locale", :defaults => {:locale => "en"}, :locale => /en|es/ do
    root :to => 'home#index'
    resources :topics
    devise_for :users do
      resources :assignments , only:[:index,:show]
    end

    resources :attempts
    resources :problems, only:[:index,:show] do
      resources :attempts
      get :use_toolkit, on: :member
    end

    namespace :admin do
      resources :problems do
        put :toggle_active
      end
      resources :assignments
      resources :groups
      resources :subjects, path: "courses"
      resources :topics
      resources :users
      resources :commands
    end
    
    namespace :teacher do
      resources :groups do
        resources :assignments, except:[:show, :index]
        resources :users do
          resources :assignments, only:[:show, :index]
        end
      end
      resources :problems
    end
  end

  # Routes for the judge results
  post '/admin/problems/judge_results'
  post '/attempts/judge_results'
  post '/problems/judge_results'

  match '/:locale/users' => 'home#index'
  match '/:locale' => 'home#index'
  get '/' => 'home#index'

end
