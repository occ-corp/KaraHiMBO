require 'spec_helper'

describe "/employees/new.html.erb" do
  include EmployeesHelper

  before(:each) do
    assigns[:employee] = stub_model(Employee,
      :new_record? => true,
      :code => "value for code",
      :name => "value for name",
      :role_id => 1
    )
  end

  it "renders new employee form" do
    render

    response.should have_tag("form[action=?][method=post]", employees_path) do
      with_tag("input#employee_code[name=?]", "employee[code]")
      with_tag("input#employee_name[name=?]", "employee[name]")
      with_tag("input#employee_role_id[name=?]", "employee[role_id]")
    end
  end
end
