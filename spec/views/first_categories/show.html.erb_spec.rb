require 'spec_helper'

describe "/first_categories/show.html.erb" do
  include FirstCategoriesHelper
  before(:each) do
    assigns[:first_category] = @first_category = stub_model(FirstCategory,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
