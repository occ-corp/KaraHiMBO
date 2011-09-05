require 'spec_helper'

describe Belong do
  before(:each) do
    @valid_attributes = {
      :employee_id => 1,
      :division_id => 1,
      :post_id => 1,
      :primary_flag => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Belong.create!(@valid_attributes)
  end
end
