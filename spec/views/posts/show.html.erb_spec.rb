require 'spec_helper'

describe "/posts/show.html.erb" do
  before(:each) do
    assigns[:post] = @post = stub_model(Post,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
