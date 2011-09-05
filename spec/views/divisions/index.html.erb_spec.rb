require 'spec_helper'

describe "/divisions/index.html.erb" do
  include DivisionsHelper

  before(:each) do
    assigns[:divisions] = [
      stub_model(Division,
        :code => "value for code",
        :name => "value for name",
        :parent_id => 1,
        :lft => 1,
        :rgt => 1
      ),
      stub_model(Division,
        :code => "value for code",
        :name => "value for name",
        :parent_id => 1,
        :lft => 1,
        :rgt => 1
      )
    ]
  end

  it "renders a list of divisions" do
    render
    response.should have_tag("tr>td", "value for code".to_s, 2)
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
