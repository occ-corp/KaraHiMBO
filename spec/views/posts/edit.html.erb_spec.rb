require 'spec_helper'

describe "/posts/edit.html.erb" do
  before(:each) do
    assigns[:post] = @post = stub_model(Post,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit post form" do
    render

    response.should have_tag("form[action=#{post_path(@post)}][method=post]") do
      with_tag('input#post_name[name=?]', "post[name]")
    end
  end
end
