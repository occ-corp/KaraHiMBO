require 'spec_helper'

describe "/actuals/show.html.erb" do
  include ActualsHelper
  before(:each) do
    assigns[:actual] = @actual = stub_model(Actual,
      :value => 1.5,
      :year => 1,
      :month => 1,
      :item_id => 1,
      :belong_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1\.5/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
