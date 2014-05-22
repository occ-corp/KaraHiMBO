ActionController::Routing::Routes.draw do |map|

  map.logout   '/logout',   :controller => 'sessions', :action => 'destroy'
  map.login    '/login',    :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup   '/signup',   :controller => 'users', :action => 'new'

  map.resources :users

  map.resource :session, :only => [:create]

  map.resources :comparisons

  map.resources :roles

  map.resources :posts

  map.resources :belongs

  map.resources :employees

  map.resources :divisions

  map.resources :items,             :only => [:new, :create, :edit, :update, :destroy]
  map.resources :second_categories, :only => [:new, :create, :edit, :update, :destroy]
  map.resources :first_categories,  :only => [:new, :create, :edit, :update, :destroy]

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect 'objective/maintenance/:id', :controller => 'objective', :action => 'maintenance'
  map.connect 'objective/export', :controller => 'objective', :action => 'export'

  map.root :controller => :objective
end
