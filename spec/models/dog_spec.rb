require 'spec_helper'

describe Dog do
  
  it "should create new instance given valid attributes" do
    @attr = {
      :name => "Sigmund",
      :color => "golden",
      :description => "awesome",
      :fleas => 1
    }
    dog = Dog.create!(@attr)
  end
end