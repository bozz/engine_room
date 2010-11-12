describe "ModelsController routes" do
  
  describe "GET 'overview" do
  
    it "should map /admin/models to { :controller => 'engine_room/models', :action => 'overview' }" do
      { :get => "/admin/models" }.should route_to( :controller => "engine_room/models", :action => "overview" )
    end

    it "should map engine_room_models_path to /admin/models" do
      engine_room_models_path.should == '/admin/models'
    end
    
    it "does not expose a list of profiles" do
      { :get => "/profiles" }.should_not be_routable
    end
  end
  
  describe "GET 'index'" do
  
    it "should map /admin/models/cats to { :controller => 'engine_room/models', :action => 'index', :modelname => 'cats' }" do
      { :get => "/admin/models/cats" }.should route_to( :controller => "engine_room/models", :action => "index", :modelname => 'cats' )
    end
  end

  describe "GET 'show'" do
  
    it "should map /admin/models/cat/23 to { :controller => 'engine_room/models', :action => 'show', :modelname => 'cat', :id => 23 }" do
      { :get => "/admin/models/cat/23" }.should route_to( :controller => "engine_room/models", :action => "show", :modelname => 'cat', :id => "23" )
    end
  end
  
  describe "GET 'edit'" do
  
    it "should map /admin/models/cat/23/edit to { :controller => 'engine_room/models', :action => 'edit', :modelname => 'cat', :id => 23 }" do
      { :get => "/admin/models/cat/23/edit" }.should route_to( :controller => "engine_room/models", :action => "edit", :modelname => 'cat', :id => "23" )
    end
  end

  describe "GET 'new'" do
  
    it "should map /admin/models/cat/new to { :controller => 'engine_room/models', :action => 'new', :modelname => 'cat' }" do
      { :get => "/admin/models/cat/new" }.should route_to( :controller => "engine_room/models", :action => "new", :modelname => 'cat' )
    end
  end
  
  describe "POST 'create'" do
  
    it "should map /admin/models/cat to { :controller => 'engine_room/models', :action => 'create', :modelname => 'cat' }" do
      { :post => "/admin/models/cat" }.should route_to( :controller => "engine_room/models", :action => "create", :modelname => 'cat' )
    end
  end
  
  describe "PUT 'update'" do
  
    it "should map /admin/models/cat/23 to { :controller => 'engine_room/models', :action => 'update', :modelname => 'cat', :id => 23 }" do
      { :put => "/admin/models/cat/23" }.should route_to( :controller => "engine_room/models", :action => "update", :modelname => 'cat', :id => "23" )
    end
  end
  
  describe "DELETE 'destroy'" do
  
    it "should map /admin/models/cat/23 to { :controller => 'engine_room/models', :action => 'destroy', :modelname => 'cat', :id => 23 }" do
      { :delete => "/admin/models/cat/23" }.should route_to( :controller => "engine_room/models", :action => "destroy", :modelname => 'cat', :id => "23" )
    end
  end
end
