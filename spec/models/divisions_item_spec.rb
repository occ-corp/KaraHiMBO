require 'spec_helper'

describe DivisionsItem do
  before(:each) do
    @valid_attributes = {
      :division_id => 1,
      :item_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    DivisionsItem.create!(@valid_attributes)
  end
end
