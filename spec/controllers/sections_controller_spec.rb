require 'spec_helper'
require 'factories'

describe EngineRoom::SectionsController do
  render_views
  
  describe "access control when not signed in" do
    
    it "should deny access to 'index'" do
      get :index
      response.should redirect_to(new_er_devise_user_session_path)
    end
    
    it "should deny access to 'create'" do
      @attr = { :name => "Dogs", :model_name => "dog" }
      post :create, :section => @attr
      response.should redirect_to(new_er_devise_user_session_path)
    end
    
    it "should deny access to 'delete'" do
      @section = Factory(:section)
      delete :destroy, :id => @section
      response.should redirect_to(new_er_devise_user_session_path)
    end
  end
  
  describe "GET 'index'" do

    before(:each) do
      sign_in Factory(:user)
      get :index
    end

    it "should be successful" do
      response.should be_success
    end

    it "should have the right title" do
      response.should have_selector("h1", :content => "Sections")
    end
  end
  
  describe "GET 'edit'" do
    
    before(:each) do
      sign_in Factory(:user)
    end
    
    it "should render the edit page" do
      section = Factory(:section)
      get :edit, :id => section
      response.should render_template('engine_room/sections/edit')
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      sign_in Factory(:user)
    end
    
    describe "failure" do
    
      before(:each) do
        @attr = { :model_name => "" }
      end
      
      it "should not create a section" do
        lambda do
          post :create, :section => @attr
        end.should_not change(Section, :count)
      end
      
      it "should not create section for invalid model_name" do
        lambda do
          post :create, :section => @attr.merge(:model_name => "Cat") # Cat model does not exist
        end.should_not change(Section, :count)
      end
      
      it "should render the new page" do
        post :create, :section => @attr
        response.should render_template('engine_room/sections/new')
      end
    end
    
    describe "success" do

      before(:each) do
        @attr = { :name => "Dogs", :model_name => "Dog" }
      end

      it "should create a section" do
        lambda do
          post :create, :section => @attr
        end.should change(Section, :count).by(1)
      end

      it "should redirect to the index page" do
        post :create, :section => @attr
        response.should redirect_to(engine_room_sections_path)
      end

      it "should have a flash message" do
        post :create, :section => @attr
        flash[:notice].should =~ /successfully created/i
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      sign_in(Factory(:user))
      @section = Factory(:section)
    end

    it "should destroy the section" do
      lambda do 
        delete :destroy, :id => @section
      end.should change(Section, :count).by(-1)
    end
    
    it "should redirect to the index page" do
      post :destroy, :id => @section
      response.should redirect_to(engine_room_sections_path)
    end
  end
end