require 'spec_helper'

describe "/employees/edit.html.erb" do
  before(:each) do
    assigns[:employee] = @employee = stub_model(Employee,
      :new_record? => false,
      :code => "value for code",
      :name => "value for name",
      :role_id => 1
    )
  end

  it "renders the edit employee form" do
    render

    response.should have_tag("form[action=#{employee_path(@employee)}][method=post]") do
      with_tag('input#employee_code[name=?]', "employee[code]")
      with_tag('input#employee_name[name=?]', "employee[name]")
      with_tag('input#employee_role_id[name=?]', "employee[role_id]")
    end
  end
end
