# -*- coding: utf-8 -*-
require 'spec_helper'

describe "/items/show.html.erb" do
  include ItemsHelper
  fixtures :items, :second_categories, :first_categories

  before(:each) do
    assigns[:item] = Item.find_with_categories("1")
  end

  def create_regexp(str)
    return Regexp.new(Regexp.escape(str))
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(create_regexp("(1) 財務の視点"))
    response.should have_text(create_regexp("3ヶ月以上の売掛低減"))
    response.should have_text(create_regexp("件数"))
    response.should have_text(create_regexp("---"))
    response.should have_text(create_regexp("18.0 件/年"))
    response.should have_text(create_regexp("3.0 件/月"))
    response.should have_text(create_regexp("2"))
  end
end
