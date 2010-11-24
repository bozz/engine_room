require 'spec_helper'
require 'factories'

describe EngineRoom::FieldsController do
  render_views
  
  describe "access control when not signed in" do
    
    it "should deny access to 'index'" do
      get :index, :section_id => 1
      response.should redirect_to(new_er_devise_user_session_path)
    end
    
    it "should deny access to 'create'" do
      @section = Factory(:section)
      @attr = { :column => "name", :field_type => "text_field", :section_id => @section.id }
      post :create, :section_id => @section, :field => @attr
      response.should redirect_to(new_er_devise_user_session_path)
    end
    
    it "should deny access to 'delete'" do
      @field = Factory(:field)
      delete :destroy, :section_id => 1, :id => @field
      response.should redirect_to(new_er_devise_user_session_path)
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      sign_in Factory(:user)
    end
    
    describe "failure" do
    
      before(:each) do
        @section = Factory(:section)
        @attr = { :column => "", :field_type => "" }
      end
      
      it "should not create a field" do
        lambda do
          post :create, :section_id => @section, :field => @attr
        end.should_not change(Field, :count)
      end
      
      it "should not create field for empty column" do
        lambda do
          post :create, :section_id => @section, :field => @attr.merge(:field_type => "boolean")
        end.should_not change(Field, :count)
      end
      
      it "should render the new page" do
        post :create, :section_id => @section, :field => @attr
        response.should render_template('engine_room/fields/new')
      end
    end
    
    describe "success" do

      before(:each) do
        @section = Factory(:section)
        @attr = { :column => "name", :field_type => "text_field", :display_type => "detail", :section_id => @section.id }
      end

      it "should create a field" do
        lambda do
          post :create, :section_id => @section, :field => @attr
        end.should change(Field, :count).by(1)
      end

      it "should redirect to the index page" do
        post :create, :section_id => @section, :field => @attr
        response.should redirect_to(edit_engine_room_section_path(@section.id))
      end

      it "should have a flash message" do
        post :create, :section_id => @section, :field => @attr
        flash[:notice].should =~ /successfully created/i
      end
    end
  end
  
  describe "DELETE 'destroy'" do

    before(:each) do
      sign_in(Factory(:user))
      @section = Factory(:section)
      @field = Factory(:field, :section => @section)
    end

    it "should destroy the field" do
      lambda do 
        delete :destroy, :section_id => @section, :id => @field
      end.should change(Field, :count).by(-1)
    end
    
    it "should redirect to the index page" do
      post :destroy, :section_id => @section, :id => @field
      response.should redirect_to(edit_engine_room_section_path(@section.id))
    end
  end
end
