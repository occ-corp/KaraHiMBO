require 'spec_helper'

describe "/comparisons/edit.html.erb" do
  before(:each) do
    assigns[:comparison] = @comparison = stub_model(Comparison,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit comparison form" do
    render

    response.should have_tag("form[action=#{comparison_path(@comparison)}][method=post]") do
      with_tag('input#comparison_name[name=?]', "comparison[name]")
    end
  end
end
