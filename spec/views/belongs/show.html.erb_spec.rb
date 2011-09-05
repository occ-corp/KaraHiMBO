require 'spec_helper'

describe "/belongs/show.html.erb" do
  include BelongsHelper
  before(:each) do
    assigns[:belong] = @belong = stub_model(Belong,
      :employee_id => 1,
      :division_id => 1,
      :post_id => 1,
      :primary_flag => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
