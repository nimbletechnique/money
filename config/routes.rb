ActionController::Routing::Routes.draw do |map|
  
  map.next_month '/items/next', :controller => 'items', :action => 'next_month'
  map.prev_month '/items/prev', :controller => 'items', :action => 'prev_month'
  map.this_month '/items/now', :controller => 'items', :action => 'this_month'
  map.reports '/items/reports', :controller => 'items', :action => 'reports', :reports => true

  map.resources :categories
  map.resources :items, :collection => {
    :auto_complete_for_item_name => :get,
    :auto_complete_for_item_form_category => :get
  }
  map.resources :users
  map.resource :session

  # allow activation
  map.connect '/activate/:activation_code', :controller=>'users', :action=>'activate'

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'items'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
