require 'spec_helper'

describe "/roles/new.html.erb" do
  before(:each) do
    assigns[:role] = stub_model(Role,
      :new_record? => true,
      :name => "value for name",
      :permission => 1
    )
  end

  it "renders new role form" do
    render

    response.should have_tag("form[action=?][method=post]", roles_path) do
      with_tag("input#role_name[name=?]", "role[name]")
      with_tag("input#role_permission[name=?]", "role[permission]")
    end
  end
end
