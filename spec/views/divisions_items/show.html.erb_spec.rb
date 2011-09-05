require 'spec_helper'

describe "/divisions_items/show.html.erb" do
  include DivisionsItemsHelper
  before(:each) do
    assigns[:divisions_item] = @divisions_item = stub_model(DivisionsItem,
      :division_id => 1,
      :item_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
