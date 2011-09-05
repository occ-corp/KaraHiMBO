require 'spec_helper'

describe "/actuals/new.html.erb" do
  include ActualsHelper

  before(:each) do
    assigns[:actual] = stub_model(Actual,
      :new_record? => true,
      :value => 1.5,
      :year => 1,
      :month => 1,
      :item_id => 1,
      :belong_id => 1
    )
  end

  it "renders new actual form" do
    render

    response.should have_tag("form[action=?][method=post]", actuals_path) do
      with_tag("input#actual_value[name=?]", "actual[value]")
      with_tag("input#actual_year[name=?]", "actual[year]")
      with_tag("input#actual_month[name=?]", "actual[month]")
      with_tag("input#actual_item_id[name=?]", "actual[item_id]")
      with_tag("input#actual_belong_id[name=?]", "actual[belong_id]")
    end
  end
end
