if ActionController::Routing.name =~ /ActionDispatch/
  #RAILS 3
  ActionDispatch::Routing::Mapper.class_eval do
    protected

    # Setup routes for +AutosigninController+.
    def devise_autosigninable(mapping, controllers)
      match "/:#{mapping.name}_id/autosignin/:autosignin_token" => 'devise/autosignin#create',
      :as => "autosignin", :via => :get
    end
  end

else
  #RAILS 2
  ActionController::Routing::RouteSet::Mapper.class_eval do
    protected

    # Setup routes for +AutosigninController+.
    def autosigninable(routes, mapping)
      routes.autosignin  "/:#{mapping.name.to_s}_id/autosignin/:autosignin_token", :controller => 'devise/autosignin', :action => 'create',  :conditions => { :method => :get }
    end
  end
end