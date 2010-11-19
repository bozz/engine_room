require 'spec_helper'
require 'factories'

describe Field do

  before(:each) do
    @section = Factory(:section)
    @attr = { :column => "name", :field_type => "text_field" }
  end

  it "should create a new instance given valid attributes" do
    @section.fields.create!(@attr)
  end

  describe "section associations" do
    
    before(:each) do
      @field = @section.fields.create(@attr)
    end

    it "should have a section attribute" do
      @field.should respond_to(:section)
    end
    
    it "should have the right associated section" do
      @field.section_id.should == @section.id
      @field.section.should == @section
    end
  end
  
  describe "validations" do
    
    it "should require a section id" do
      Field.new(@attr).should_not be_valid
    end
    
    it "should require nonblank column" do
      @section.fields.build(@attr.merge(:column => "  ")).should_not be_valid
    end
    
    it "should require nonblank field_type" do
      @section.fields.build(@attr.merge(:field_type => " ")).should_not be_valid
    end
    
    it "should reject invalid field_types" do
      @section.fields.build(@attr.merge(:field_type => "foo")).should_not be_valid
    end
    
    it "should accept valid field_types" do
      @section.fields.build(@attr.merge(:field_type => "boolean")).should be_valid
    end
  end
end
