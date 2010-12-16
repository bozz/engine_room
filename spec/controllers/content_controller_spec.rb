require 'spec_helper'
require 'factories'

describe EngineRoom::ContentController do
  render_views
  
  describe "access control when not signed in" do
    
    before(:each) do
      @section = Factory(:section)
    end

    it "should deny access to 'index'" do
      get :index, :section_name => @section.name
      response.should redirect_to(new_er_devise_user_session_path)
    end
    
    it "should deny access to 'create'" do
      @attr = { :name => "Fifi" }
      post :create, :section_name => @section.name, :dog => @attr
      response.should redirect_to(new_er_devise_user_session_path)
    end
    
    it "should deny access to 'delete'" do
      dog = Factory(:dog)
      delete :destroy, :section_name => @section.name, :id => dog
      response.should redirect_to(new_er_devise_user_session_path)
    end
  end
  
  describe "GET 'index'" do

    before(:each) do
      sign_in Factory(:user)
      section = Factory(:section)
      get :index, :section_name => section.name
    end

    it "should be successful" do
      response.should be_success
    end
  end
  
  describe "GET 'edit'" do
    
    before(:each) do
      sign_in Factory(:user)
      @section = Factory(:section)
    end
    
    it "should render the edit page" do
      dog = Factory(:dog)
      get :edit, :section_name => @section.name, :id => dog.id
      response.should render_template('engine_room/content/edit')
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      sign_in Factory(:user)
      @section = Factory(:section)
    end
    
    describe "failure" do
    
      before(:each) do
        @attr = { :name => "" }
      end
      
      it "should not create a dog with invalid attributes" do
        lambda do
          post :create, :section_name => @section.name, :dog => @attr
        end.should_not change(Dog, :count)
      end
      
      it "should render the new page" do
        post :create, :section_name => @section.name, :dog => @attr
        response.should render_template('engine_room/content/new')
      end
    end
    
    describe "success" do

      before(:each) do
        @attr = { :name => "Fifi", :color => "black", :fleas => 2 }
      end

      it "should create a dog" do
        lambda do
          post :create, :section_name => @section.name, :dog => @attr
        end.should change(Dog, :count).by(1)
      end

      it "should redirect to the index page" do
        post :create, :section_name => @section.name, :dog => @attr
        response.should redirect_to({:controller => "content", :action => :index, :section_name => @section.name})
      end

      it "should have a flash message" do
        post :create, :section_name => @section.name, :dog => @attr
        flash[:notice].should =~ /successfully created/i
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      sign_in(Factory(:user))
      @section = Factory(:section)
      @dog = Factory(:dog)
    end

    it "should destroy the dog" do
      lambda do 
        delete :destroy, :section_name => @section.name, :id => @dog
      end.should change(Dog, :count).by(-1)
    end
    
    it "should redirect to the index page" do
      post :destroy, :section_name => @section.name, :id => @dog
      response.should redirect_to({:controller => "content", :action => :index, :section_name => @section.name})
    end
  end
end

