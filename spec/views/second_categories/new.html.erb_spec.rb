require 'spec_helper'

describe "/second_categories/new.html.erb" do
  include SecondCategoriesHelper

  before(:each) do
    assigns[:second_category] = stub_model(SecondCategory,
      :new_record? => true,
      :name => "value for name",
      :first_category_id => 1
    )
  end

  it "renders new second_category form" do
    render

    response.should have_tag("form[action=?][method=post]", second_categories_path) do
      with_tag("input#second_category_name[name=?]", "second_category[name]")
      with_tag("input#second_category_first_category_id[name=?]", "second_category[first_category_id]")
    end
  end
end
