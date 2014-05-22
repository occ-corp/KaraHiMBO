require 'spec_helper'

describe "/belongs/index.html.erb" do
  before(:each) do
    assigns[:belongs] = [
      stub_model(Belong,
        :employee_id => 1,
        :division_id => 1,
        :post_id => 1,
        :primary_flag => 1
      ),
      stub_model(Belong,
        :employee_id => 1,
        :division_id => 1,
        :post_id => 1,
        :primary_flag => 1
      )
    ]
  end

  it "renders a list of belongs" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
