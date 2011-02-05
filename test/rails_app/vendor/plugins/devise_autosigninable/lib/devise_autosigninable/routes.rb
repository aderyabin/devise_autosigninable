ActionController::Routing::RouteSet::Mapper.class_eval do

  protected

    # Setup routes for +AutosigninController+.
    def autosigninable(routes, mapping)
      routes.autosignin ::Devise.autosignin_url, :controller => 'autosignin', :action => 'create',  :conditions => { :method => :get }
    end

end