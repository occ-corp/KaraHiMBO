require 'spec_helper'

describe "/comparisons/new.html.erb" do
  include ComparisonsHelper

  before(:each) do
    assigns[:comparison] = stub_model(Comparison,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new comparison form" do
    render

    response.should have_tag("form[action=?][method=post]", comparisons_path) do
      with_tag("input#comparison_name[name=?]", "comparison[name]")
    end
  end
end
