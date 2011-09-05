require 'spec_helper'

describe "/second_categories/show.html.erb" do
  include SecondCategoriesHelper
  before(:each) do
    assigns[:second_category] = @second_category = stub_model(SecondCategory,
      :name => "value for name",
      :first_category_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(//)
  end
end
