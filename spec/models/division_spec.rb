# -*- coding: utf-8 -*-
require 'spec_helper'

describe Division do
  describe "should create a new instance" do 
    before(:each) do
      @valid_attributes = {
        :code => "value for code",
        :name => "value for name",
        :parent_id => 1,
        :lft => 1,
        :rgt => 1
      }
      @not_valid_attributes = {
        :parent_id => 1,
        :lft => 1,
        :rgt => 1
      }

    end

    it "given valid attributes" do
      Division.create!(@valid_attributes).should be_true
    end

    it "given not valid attributes" do 
      proc { Division.create!(@not_valid_attributes) }.should raise_error
    end
  end


  #  Example Hierarchy Diagram
  #       (id = 1)
  #          *
  #        /    \
  #   (3) *      * (2)
  #       |    /   \ 
  #   (6) *   *     * (4)
  #       |  (5)
  #   (7) *      
  #
  describe "children_ids を呼び出したとき" do
    fixtures :divisions
    
    before do
      @parent = divisions(:data1)
      @divisions = divisions(:data2, :data3, :data4, :data5, :data6, :data7)
    end
    
    it "下位部署の ID(s) を取得できること" do
      ids = @parent.children_ids
      ids.size.should eql(@divisions.size), "下位部署の数が違う"
      
      @divisions.each do |d|
        ids.include?(d.id).should be_true, "下位所属に含まれていない部署がある"
      end
    end
    
    it "自身を含めた下位部署の ID(s) を取得できること" do
      @divisions << @parent
      
      ids = @parent.children_ids(:include_own => true)
      ids.size.should eql(@divisions.size), "下位部署の数が違う"
      
      @divisions.each do |d|
        ids.include?(d.id).should be_true, "下位所属に含まれていない部署がある"
      end
    end  
  end

  describe "max_level を呼び出した時" do
    it "木の深さを取得できる" do
      Division.max_level.should eql(3)
    end
  end

  describe "full_name を呼び出した時" do
    fixtures :divisions

    before do
      @division = divisions(:data6)
    end

    it "上位部署からの名前を連結して出力すること" do
      @division.full_name.should eql("全社 営業販売部門 営業部")
    end

    it "引数があればその文字列を部署間に入れて出力すること" do
      @division.full_name(" -> ").should eql("全社 -> 営業販売部門 -> 営業部")
    end
  end

  describe "belong_employees を呼び出した時" do
    fixtures :divisions, :belongs, :employees

    before do 
      @division = divisions(:data1)
    end

    it "自身を含む部署以下に所属する社員を取得できること" do
      employees = @division.belong_employees
      employees.should have(20).items
    end
  end
end
