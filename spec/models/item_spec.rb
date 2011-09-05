# -*- coding: utf-8 -*-
require 'spec_helper'

describe Item do
  describe "should create a new instance" do 
    before(:each) do
      @valid_attributes = {
        :name => "value for name",
        :second_category_id => 1,
        :unit => "value for unit",
        :target_index => "value for target_index",
        :entire_index => 1.5,
        :person_year_index => 1.5,
        :person_month_index => 1.5,
        :comparison_id => 1
      }
    end
    
    it "given valid attributes" do
      Item.create!(@valid_attributes)
    end
  end

  describe "find_with_categories を呼び出した時" do
    fixtures :items, :second_categories, :first_categories

    before do 
      @item = Item.find_with_categories("1")
    end

    it "first_category の名前が取得できていること" do
      @item.first_category_name.should eql("(1) 朝の目的")
    end

    it "second_category の名前が取得できていること" do
      @item.second_category_name.should eql("挨拶")
    end
  end
end
