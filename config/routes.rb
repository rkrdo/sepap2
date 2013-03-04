Sepap2::Application.routes.draw do
  resources :commands

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
    resources :problems
    resources :assignments
    resources :groups
    resources :subjects
    resources :topics
    resources :users
  end
end
#devise_for :users

  match '/:locale/users' => 'home#index'
  match '/:locale' => 'home#index'
  get '/' => 'home#index'

end
