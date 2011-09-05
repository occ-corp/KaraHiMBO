require 'spec_helper'

describe "/second_categories/edit.html.erb" do
  include SecondCategoriesHelper

  before(:each) do
    assigns[:second_category] = @second_category = stub_model(SecondCategory,
      :new_record? => false,
      :name => "value for name",
      :first_category_id => 2
    )
  end

  it "renders the edit second_category form" do
    render

    response.should have_tag("form[action=#{second_category_path(@second_category)}][method=post]") do
      with_tag('input#second_category_name[name=?]', "second_category[name]")
      with_tag('input#second_category_first_category_id[name=?]', "second_category[first_category_id]")
    end
  end
end
