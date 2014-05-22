require 'spec_helper'

describe "/belongs/new.html.erb" do
  before(:each) do
    assigns[:belong] = stub_model(Belong,
      :new_record? => true,
      :employee_id => 1,
      :division_id => 1,
      :post_id => 1,
      :primary_flag => 1
    )
  end

  it "renders new belong form" do
    render

    response.should have_tag("form[action=?][method=post]", belongs_path) do
      with_tag("input#belong_employee_id[name=?]", "belong[employee_id]")
      with_tag("input#belong_division_id[name=?]", "belong[division_id]")
      with_tag("input#belong_post_id[name=?]", "belong[post_id]")
      with_tag("input#belong_primary_flag[name=?]", "belong[primary_flag]")
    end
  end
end
