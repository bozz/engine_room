require 'spec_helper'

describe EngineRoom::PagesController do
  render_views
  
  describe "GET 'dashboard'" do

    describe "when not signed in" do

      before(:each) do
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