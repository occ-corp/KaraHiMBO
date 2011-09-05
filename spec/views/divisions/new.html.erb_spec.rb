require 'spec_helper'

describe "/divisions/new.html.erb" do
  include DivisionsHelper

  before(:each) do
    assigns[:division] = stub_model(Division,
      :new_record? => true,
      :code => "value for code",
      :name => "value for name",
      :parent_id => 1,
      :lft => 1,
      :rgt => 1
    )
  end

  it "renders new division form" do
    render

    response.should have_tag("form[action=?][method=post]", divisions_path) do
      with_tag("input#division_code[name=?]", "division[code]")
      with_tag("input#division_name[name=?]", "division[name]")
      with_tag("input#division_parent_id[name=?]", "division[parent_id]")
      with_tag("input#division_lft[name=?]", "division[lft]")
      with_tag("input#division_rgt[name=?]", "division[rgt]")
    end
  end
end
