Rails.application.routes.draw do
  devise_for :sys_users
	scope :as => :main do
		get 'index' => 'page#index', :as => 'index'
	  get 'theme' => 'page#theme', :as => 'theme'
	end
	root :to => 'page#index'
end
