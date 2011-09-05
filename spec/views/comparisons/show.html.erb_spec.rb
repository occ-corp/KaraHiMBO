require 'spec_helper'

describe "/comparisons/show.html.erb" do
  include ComparisonsHelper
  before(:each) do
    assigns[:comparison] = @comparison = stub_model(Comparison,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
