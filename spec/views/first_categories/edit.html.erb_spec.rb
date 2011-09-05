require 'spec_helper'

describe "/first_categories/edit.html.erb" do
  include FirstCategoriesHelper

  before(:each) do
    assigns[:first_category] = @first_category = stub_model(FirstCategory,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit first_category form" do
    render

    response.should have_tag("form[action=#{first_category_path(@first_category)}][method=post]") do
      with_tag('input#first_category_name[name=?]', "first_category[name]")
    end
  end
end
