Rails.application.routes.draw do

  engine_room_path = EngineRoom::Engine.config.mount_at

  namespace :er_devise, :path => engine_room_path do
    devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :sign_up => 'register' }
  end

  namespace :engine_room, :path => engine_room_path do

    root :to => "pages#dashboard"

    get 'settings' => "pages#settings"

    get    'users/current' => "users#edit_current_user", :as => :current_user
    put    'users/current' => "users#update_current_user", :as => :current_user
    delete 'users/current' => "users#destroy_current_user", :as => :current_user
    resources :users

    resources :sections do
      resources :fields
    end

    controller :content do
      #get     'content/:belongs_to_section/:belongs_to_id/:section_name/new'       => :new
      #get     'content/:belongs_to_section/:belongs_to_id/:section_name'           => :index
      #post    'content/:belongs_to_section/:belongs_to_id/:section_name'           => :create
      #get     'content/:belongs_to_section/:belongs_to_id/:section_name/:id'       => :show,    :constraints => { :belongs_to_id => /\d+/ }
      #get     'content/:belongs_to_section/:belongs_to_id/:section_name/:id/edit'  => :edit,    :constraints => { :belongs_to_id => /\d+/ }
      #put     'content/:belongs_to_section/:belongs_to_id/:section_name/:id'       => :update,  :constraints => { :belongs_to_id => /\d+/ }
      #delete  'content/:belongs_to_section/:belongs_to_id/:section_name/:id'       => :destroy, :constraints => { :belongs_to_id => /\d+/ }

      get     'content'                         => :overview
      get     'content/:section_name'           => :index
      get     'content/:section_name/new'       => :new
      post    'content/:section_name'           => :create
      get     'content/:section_name/:id'       => :show,    :constraints => { :id => /\d+/ }
      get     'content/:section_name/:id/edit'  => :edit,    :constraints => { :id => /\d+/ }
      put     'content/:section_name/:id'       => :update,  :constraints => { :id => /\d+/ }
      delete  'content/:section_name/:id'       => :destroy, :constraints => { :id => /\d+/ }
    end

    # workaround for models resource for including dynamic segment
    # resources :models
    controller :models do
      get     'models'                     => :overview
      get     'model/:modelname'           => :index
      get     'model/:modelname/new'       => :new
      post    'model/:modelname'           => :create
      get     'model/:modelname/:id'       => :show
      get     'model/:modelname/:id/edit'  => :edit
      put     'model/:modelname/:id'       => :update
      delete  'model/:modelname/:id'       => :destroy
    end
  end

  #mount_at = EngineRoom::Engine.config.mount_at
  #resources :tests, :controller => "engine_room/tests", :only => [ :index ]
                          #:path_prefix => mount_at,
                          #:name_prefix => "er_"

end
