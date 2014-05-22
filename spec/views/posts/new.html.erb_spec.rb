require 'spec_helper'

describe "/posts/new.html.erb" do
  before(:each) do
    assigns[:post] = stub_model(Post,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new post form" do
    render

    response.should have_tag("form[action=?][method=post]", posts_path) do
      with_tag("input#post_name[name=?]", "post[name]")
    end
  end
end
