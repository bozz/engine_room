Rails.application.routes.draw do |map|
  
  engine_room_path = 'er'

  namespace :engine_room, :path => engine_room_path do
    resources :tests, :only => [ :index ]

    root :to => "pages#dashboard"

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
