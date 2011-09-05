require 'spec_helper'

describe "/divisions_items/new.html.erb" do
  include DivisionsItemsHelper

  before(:each) do
    assigns[:divisions_item] = stub_model(DivisionsItem,
      :new_record? => true,
      :division_id => 1,
      :item_id => 1
    )
  end

  it "renders new divisions_item form" do
    render

    response.should have_tag("form[action=?][method=post]", divisions_items_path) do
      with_tag("input#divisions_item_division_id[name=?]", "divisions_item[division_id]")
      with_tag("input#divisions_item_item_id[name=?]", "divisions_item[item_id]")
    end
  end
end
