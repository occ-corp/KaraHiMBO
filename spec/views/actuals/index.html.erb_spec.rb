require 'spec_helper'

describe "/actuals/index.html.erb" do
  include ActualsHelper

  before(:each) do
    assigns[:actuals] = [
      stub_model(Actual,
        :value => 1.5,
        :year => 1,
        :month => 1,
        :item_id => 1,
        :belong_id => 1
      ),
      stub_model(Actual,
        :value => 1.5,
        :year => 1,
        :month => 1,
        :item_id => 1,
        :belong_id => 1
      )
    ]
  end

  it "renders a list of actuals" do
    render
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
