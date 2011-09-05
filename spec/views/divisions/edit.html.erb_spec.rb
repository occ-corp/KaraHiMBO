require 'spec_helper'

describe "/divisions/edit.html.erb" do
  include DivisionsHelper

  before(:each) do
    assigns[:division] = @division = stub_model(Division,
      :new_record? => false,
      :code => "value for code",
      :name => "value for name",
      :parent_id => 1,
      :lft => 1,
      :rgt => 1
    )
  end

  it "renders the edit division form" do
    render

    response.should have_tag("form[action=#{division_path(@division)}][method=post]") do
      with_tag('input#division_code[name=?]', "division[code]")
      with_tag('input#division_name[name=?]', "division[name]")
      with_tag('input#division_parent_id[name=?]', "division[parent_id]")
      with_tag('input#division_lft[name=?]', "division[lft]")
      with_tag('input#division_rgt[name=?]', "division[rgt]")
    end
  end
end
