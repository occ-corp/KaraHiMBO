require 'spec_helper'

describe "/employees/show.html.erb" do
  include EmployeesHelper
  before(:each) do
    assigns[:employee] = @employee = stub_model(Employee,
      :code => "value for code",
      :name => "value for name",
      :role_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ code/)
    response.should have_text(/value\ for\ name/)
    response.should have_text(/1/)
  end
end
