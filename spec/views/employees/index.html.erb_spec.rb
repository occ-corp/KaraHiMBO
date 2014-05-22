require 'spec_helper'

describe "/employees/index.html.erb" do
  before(:each) do
    assigns[:employees] = [
      stub_model(Employee,
        :code => "value for code",
        :name => "value for name",
        :role_id => 1
      ),
      stub_model(Employee,
        :code => "value for code",
        :name => "value for name",
        :role_id => 1
      )
    ]
  end

  it "renders a list of employees" do
    render
    response.should have_tag("tr>td", "value for code".to_s, 2)
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
