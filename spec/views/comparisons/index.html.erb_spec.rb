require 'spec_helper'

describe "/comparisons/index.html.erb" do
  include ComparisonsHelper

  before(:each) do
    assigns[:comparisons] = [
      stub_model(Comparison,
        :name => "value for name"
      ),
      stub_model(Comparison,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of comparisons" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
