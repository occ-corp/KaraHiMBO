require 'spec_helper'

describe "/posts/index.html.erb" do
  include PostsHelper

  before(:each) do
    assigns[:posts] = [
      stub_model(Post,
        :name => "value for name"
      ),
      stub_model(Post,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of posts" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
