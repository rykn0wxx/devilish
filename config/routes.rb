Rails.application.routes.draw do
	devise_for :sys_users

	resources :tasks do
		collection do
			get :import
			post :do_import
		end
	end

	scope :as => :main do
		get 'index' => 'page#index', :as => 'index'
	  get 'theme' => 'page#theme', :as => 'theme'
		get 'tasks' => 'task#index', :as => 'tasks'
	end

	root :to => 'page#index'
end
