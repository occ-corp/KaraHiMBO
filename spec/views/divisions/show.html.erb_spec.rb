require 'spec_helper'

describe "/divisions/show.html.erb" do
  include DivisionsHelper
  before(:each) do
    assigns[:division] = @division = stub_model(Division,
      :code => "value for code",
      :name => "value for name",
      :parent_id => 1,
      :lft => 1,
      :rgt => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ code/)
    response.should have_text(/value\ for\ name/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
