require 'spec_helper'

describe "/divisions_items/index.html.erb" do
  include DivisionsItemsHelper

  before(:each) do
    assigns[:divisions_items] = [
      stub_model(DivisionsItem,
        :division_id => 1,
        :item_id => 1
      ),
      stub_model(DivisionsItem,
        :division_id => 1,
        :item_id => 1
      )
    ]
  end

  it "renders a list of divisions_items" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
