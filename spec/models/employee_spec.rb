# -*- coding: utf-8 -*-
require 'spec_helper'

describe Employee do
  before(:each) do
    @valid_attributes = {
      :code => "value for code",
      :name => "value for name",
      :role_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Employee.create!(@valid_attributes)
  end

  describe "self.find_by_division_id を呼び出した時" do
    fixtures :employees, :divisions, :posts, :belongs
    
    before(:each) do 
      @root = divisions(:data1).id
      @kenkyu = divisions(:data2).id
      @eigyou = divisions(:data3).id
      @hanbai = divisions(:data7).id
    end

    it "指定された Division 以下に所属する社員を取得できること" do
      Employee.find_by_division_id(@root).should have(20).items, <<-EOS
        全社以下に所属している社員数が合わない
      EOS
      Employee.find_by_division_id(@kenkyu).should have(12).items, <<-EOS
        研究開発部門以下に所属している社員数が合わない
      EOS
      Employee.find_by_division_id(@eigyou).should have(9).items, <<-EOS
        営業販売部門以下に所属している社員数が合わない
      EOS
      Employee.find_by_division_id(@hanbai).should have(7).items, <<-EOS
        販売課以下に所属している社員数が合わない
      EOS
    end
  end

  describe "divisions_and_posts を呼び出した時" do
    fixtures :employees, :divisions, :posts, :belongs

    before do 
      @kenkyu = divisions(:data2)
      @system = divisions(:data4)
      @employee = employees(:data1)
    end

    describe "Division を渡せば" do
      it "その部署以下にいる社員(本人のみ)の所属と役職を取得できること" do
        dps = @employee.divisions_and_posts(@kenkyu)
        dps.size.should eql(2)

        dps = @employee.divisions_and_posts(@system)
        dps.size.should eql(1)
      end
    end

    describe "DivisionID を渡せば" do
      it "その部署以下にいる社員(本人のみ)の所属と役職を取得できること" do
        dps = @employee.divisions_and_posts(@kenkyu.id)
        dps.size.should eql(2)

        dps = @employee.divisions_and_posts(@system.id)
        dps.size.should eql(1)

        dps = @employee.divisions_and_posts(@kenkyu.id.to_s)
        dps.size.should eql(2)

        dps = @employee.divisions_and_posts(@system.id.to_s)
        dps.size.should eql(1)
      end
    end
  end

  describe "primary_belong を呼び出した時" do
    fixtures :employees, :posts, :belongs

    it "primary_flag が 1 の belong を取得できること" do
      employee = employees(:data1)
      belong = employee.primary_belong
      belong.primary_flag.should eql(1)
    end
  end

  describe "#full_name_with_belong を呼び出したとき" do
    fixtures :employees, :posts, :belongs, :divisions

    it "所属名を含めた社員名を取得できること" do
      @employee = employees(:data1)
      @belong1 = belongs(:data1)
      @belong2 = belongs(:data2)

      @employee.full_name_with_belong.should eql("全社 研究開発部門 : 蓼 庄二郎 部門長"), "優先所属での full_name が取得できない"
      @employee.full_name_with_belong(@belong1).should eql("全社 研究開発部門 : 蓼 庄二郎 部門長")
      @employee.full_name_with_belong(@belong2).should eql("全社 研究開発部門 システム開発部門 : 蓼 庄二郎 部長")
      @employee.full_name_with_belong(@belong1, " - ").should eql("全社 研究開発部門 - 蓼 庄二郎 部門長")
    end
  end
end
