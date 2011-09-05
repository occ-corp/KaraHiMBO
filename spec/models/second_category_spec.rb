require 'spec_helper'

describe SecondCategory do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :first_category_id => 2
    }
  end

  it "should create a new instance given valid attributes" do
    SecondCategory.create!(@valid_attributes)
  end
end
