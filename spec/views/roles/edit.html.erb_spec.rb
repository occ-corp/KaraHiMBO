require 'spec_helper'

describe "/roles/edit.html.erb" do
  include RolesHelper

  before(:each) do
    assigns[:role] = @role = stub_model(Role,
      :new_record? => false,
      :name => "value for name",
      :permission => 1
    )
  end

  it "renders the edit role form" do
    render

    response.should have_tag("form[action=#{role_path(@role)}][method=post]") do
      with_tag('input#role_name[name=?]', "role[name]")
      with_tag('input#role_permission[name=?]', "role[permission]")
    end
  end
end
