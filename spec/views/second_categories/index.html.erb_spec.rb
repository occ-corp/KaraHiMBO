require 'spec_helper'

describe "/second_categories/index.html.erb" do
  include SecondCategoriesHelper

  before(:each) do
    assigns[:second_categories] = [
      stub_model(SecondCategory,
        :name => "value for name",
        :first_category_id => 1
      ),
      stub_model(SecondCategory,
        :name => "value for name",
        :first_category_id => 1
      )
    ]
  end

  it "renders a list of second_categories" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
