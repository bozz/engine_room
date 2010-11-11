require 'spec_helper'

describe EngineRoom::ModelsController do
  render_views
  
  describe "GET 'overview'" do

    describe "when not signed in" do

      before(:each) do
        get :overview
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right heading" do
        response.should have_selector("h1", :content => "Models")
      end
    end
  end
  
  describe "GET 'index'" do

    describe "when not signed in" do

      before(:each) do
        get :index, :modelname => "milk"
      end

      it "should be successful" do
        response.should be_success
      end

      #it "should have the right heading" do
      #  response.should have_selector("h1", :content => "Models")
      #end
    end
  end
end