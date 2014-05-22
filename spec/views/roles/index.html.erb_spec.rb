require 'spec_helper'

describe "/roles/index.html.erb" do
  before(:each) do
    assigns[:roles] = [
      stub_model(Role,
        :name => "value for name",
        :permission => 1
      ),
      stub_model(Role,
        :name => "value for name",
        :permission => 1
      )
    ]
  end

  it "renders a list of roles" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
