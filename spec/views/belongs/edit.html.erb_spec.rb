require 'spec_helper'

describe "/belongs/edit.html.erb" do
  include BelongsHelper

  before(:each) do
    assigns[:belong] = @belong = stub_model(Belong,
      :new_record? => false,
      :employee_id => 1,
      :division_id => 1,
      :post_id => 1,
      :primary_flag => 1
    )
  end

  it "renders the edit belong form" do
    render

    response.should have_tag("form[action=#{belong_path(@belong)}][method=post]") do
      with_tag('input#belong_employee_id[name=?]', "belong[employee_id]")
      with_tag('input#belong_division_id[name=?]', "belong[division_id]")
      with_tag('input#belong_post_id[name=?]', "belong[post_id]")
      with_tag('input#belong_primary_flag[name=?]', "belong[primary_flag]")
    end
  end
end
