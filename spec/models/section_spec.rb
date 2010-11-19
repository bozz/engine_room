require 'spec_helper'
require 'factories'

describe Section do
  
  before(:each) do
    @attr = { 
      :name => "Section Name", 
      :model_name => "dog"
    }
  end
  
  it "should create a new instance given valid attributes" do
    Section.create!(@attr)
  end

  it "should require a name" do
    no_name_section = Section.new(@attr.merge(:name => ""))
    no_name_section.should_not be_valid
  end
  
  it "should require a model_name" do
    no_email_section = Section.new(@attr.merge(:model_name => ""))
    no_email_section.should_not be_valid
  end
  
  it "should reject invalid model_names" do
    section = Section.new(@attr.merge(:model_name => "foobar"))
    section.should_not be_valid
  end
  
  it "should accept 'dog' as valid model name" do
    # dog is dummy model
    Section.model_names.include?("dog").should be_true
  end
  
  it "should return model from model_name" do
    section = Factory(:section)
    section.model.name.should == section.model_name.camelize
  end
  
  it "should return valid column names" do
    section = Factory(:section)
    section.column_names.should == ["id","name","color","description","fleas","created_at","updated_at"]
  end
  
  describe "field associations" do
    
    before(:each) do
      @section = Section.create(@attr)
      @field1 = Factory(:field, :section => @section, :sort_order => 5)
      @field2 = Factory(:field, :section => @section, :sort_order => 2)
    end
    
    it "should have a fields attribute" do
      @section.should respond_to(:fields)
    end
    
    it "should have the right fields in the right order" do
      @section.fields.should == [@field2, @field1]
    end
    
    it "should destroy associated fields" do
      @section.destroy
      [@field1, @field2].each do |field|
        Field.find_by_id(field.id).should be_nil
      end
    end
  end
end
