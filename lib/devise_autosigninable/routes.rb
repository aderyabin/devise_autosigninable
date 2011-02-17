ActionController::Routing::RouteSet::Mapper.class_eval do

  protected

    # Setup routes for +AutosigninController+.
    def autosigninable(routes, mapping)
      routes.autosignin  "/:#{mapping.name.to_s}_id/autosignin/:autosignin_token", :controller => 'autosignin', :action => 'create',  :conditions => { :method => :get }
    end

end