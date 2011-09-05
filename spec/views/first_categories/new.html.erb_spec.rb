require 'spec_helper'

describe "/first_categories/new.html.erb" do
  include FirstCategoriesHelper

  before(:each) do
    assigns[:first_category] = stub_model(FirstCategory,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new first_category form" do
    render

    response.should have_tag("form[action=?][method=post]", first_categories_path) do
      with_tag("input#first_category_name[name=?]", "first_category[name]")
    end
  end
end
