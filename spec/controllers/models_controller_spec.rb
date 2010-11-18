require 'spec_helper'

describe EngineRoom::ModelsController do
  render_views
  
  describe "GET 'overview'" do

    describe "when not signed in" do

      before(:each) do
        get :overview
      end

      it "should not be successful" do
        response.should_not be_success
      end

      it "should redirect to login page" do
        response.should redirect_to(new_er_devise_user_session_path)
      end 
    end
    
    describe "when signed in" do

      before(:each) do
        sign_in Factory(:user)
        get :overview
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right heading" do
        response.should have_selector("h1", :content => "Pages")
      end
    end
  end
  
  describe "GET 'index'" do

    describe "when not signed in" do

      before(:each) do
        get :index, :modelname => "milk"
      end

      it "should be successful" do
        response.should_not be_success
      end
    end
    
    describe "when signed in" do

      before(:each) do
        sign_in Factory(:user)
      end

      it "should get redirected to overview when model doesn't exist" do
        get :index, :modelname => "milk"
        response.should redirect_to("/admin/models")
      end
    end
  end
end