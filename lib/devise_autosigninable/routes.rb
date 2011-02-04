ActionController::Routing::RouteSet::Mapper.class_eval do

  protected

    # Setup routes for +AutosigninSessionsController+.
    #
    def autosigninable(routes, mapping)
      routes.autosignin ::Devise.autosignin_path, :controller => 'autosignin', :action => 'create',  :conditions => { :method => :get }
    end

end