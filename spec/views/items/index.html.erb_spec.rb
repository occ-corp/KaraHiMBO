require 'spec_helper'

describe "/items/index.html.erb" do
  include ItemsHelper

  before(:each) do
    assigns[:items] = [
      stub_model(Item,
        :name => "value for name",
        :second_category_id => 1, #
        :unit => "value for unit",
        :target_index => "value for target_index",
        :entire_index => 1.5,
        :person_year_index => 1.5,
        :person_month_index => 1.5,
        :comparison_id => 1
      ),
      stub_model(Item,
        :name => "value for name",
        :second_category_id => 1,
        :unit => "value for unit",
        :target_index => "value for target_index",
        :entire_index => 1.5,
        :person_year_index => 1.5,
        :person_month_index => 1.5,
        :comparison_id => 1
      )
    ]
  end

  it "renders a list of items" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for unit".to_s, 2)
    response.should have_tag("tr>td", "value for target_index".to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", 1.5.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
