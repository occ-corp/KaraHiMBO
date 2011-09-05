require 'spec_helper'

describe "/users/index.html.erb" do
  include UsersHelper

  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :employee_id => 1
      ),
      stub_model(User,
        :employee_id => 1
      )
    ]
  end

  it "renders a list of users" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
