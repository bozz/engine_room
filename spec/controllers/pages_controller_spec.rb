require 'spec_helper'
require 'factories'

describe EngineRoom::PagesController do
  render_views
  
  describe "GET 'dashboard'" do

    describe "when not signed in" do

      before(:each) do
        get :dashboard
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
        get :dashboard
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right heading" do
        response.should have_selector("h1", :content => "Dashboard")
      end
    end
  end
end