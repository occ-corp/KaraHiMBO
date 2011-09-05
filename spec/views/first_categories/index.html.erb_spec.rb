require 'spec_helper'

describe "/first_categories/index.html.erb" do
  include FirstCategoriesHelper

  before(:each) do
    assigns[:first_categories] = [
      stub_model(FirstCategory,
        :name => "value for name"
      ),
      stub_model(FirstCategory,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of first_categories" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
