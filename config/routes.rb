Rails.application.routes.draw do
  
  engine_room_path = 'admin'
  
  namespace :er_devise, :path => engine_room_path do
    devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :sign_up => 'register' }
  end
  
  namespace :engine_room, :path => engine_room_path do
    
    root :to => "pages#dashboard"
    
    #devise_for :users, :module => "devise", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :sign_up => 'register' }
    
    # workaround for models resource for including dynamic segment
    # resources :models
    controller :models do
      get     'models'                      => :overview
      get     'models/:modelname'           => :index
      get     'models/:modelname/new'       => :new
      post    'models/:modelname'           => :create
      get     'models/:modelname/:id'       => :show
      get     'models/:modelname/:id/edit'  => :edit
      put     'models/:modelname/:id'       => :update
      delete  'models/:modelname/:id'       => :destroy
    end
  end
  
  #mount_at = EngineRoom::Engine.config.mount_at
  #resources :tests, :controller => "engine_room/tests", :only => [ :index ]
                          #:path_prefix => mount_at,
                          #:name_prefix => "er_"

end
