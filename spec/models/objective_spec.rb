# -*- coding: utf-8 -*-
require 'spec_helper'

describe Objective do
  fixtures :first_categories, :second_categories, :items,
           :divisions, :belongs, :divisions_items, :actuals

  describe "get が呼ばれたとき" do
    before do
      @root_a = divisions(:data1)
      @items = Objective.get(@root_a.id)
    end

    it "項目を全て取得すること" do
      @items.should have(7).items
    end

    it "カテゴリを含めた項目を取得すること" do
      item = @items.first
      item["first_category"].should eql("(1) 朝の目的")
      item["second_category"].should eql("挨拶")
    end
  end

  describe "get_with_actuals が呼ばれたとき" do
    before do
      @belong1 = belongs(:data1) # 研究開発部門所属
      @belong3 = belongs(:data3) # 営業販売部門所属
      @range = DateMonth.period(2009)
    end

    it "belong_id に対応する項目を全て取得すること" do
      Objective.get_with_actual(@belong1.id, @range).should have(6).items
      Objective.get_with_actual(@belong3.id, @range).should have(5).items
    end

    it "belong_id に対応する actual の値を取得できていること" do
      item = Objective.get_with_actual(@belong1.id, @range).select {
        |i| i.id == 1
      }[0]

      item["actual_2009_4"].should eql(170.to_f)
      item["actual_2010_1"].should eql(88.to_f)
    end
  end
end

describe Objective::Rank do
  describe "#getを呼ばれたとき" do
    it "引数に対応するランクを取得できること" do
      Objective::Rank.get(1).should eql("E")
      Objective::Rank.get(100).should eql("S")
      Objective::Rank.get(85).should eql("A")
      Objective::Rank.get(84).should eql("B")
    end
  end
end

describe "actual_rate が呼ばれたとき" do
  before do
    @more = 1 # 向上目標 (〜以上を目指す)
    @less = 0 # 抑制目標 (〜以下に抑える)
  end

  describe "向上目標の" do
    before do
      @comparison = @more
    end

    describe "目標指数が 0 なら" do
      before do
        @target = 0
      end

      it "実績値が0でなければ達成率 100% となること" do
        actual_rate(80, @target, @comparison).should eql(100)
      end
      
      it "実績値が0であれば達成率 0% となること" do
        actual_rate(0, @target, @comparison).should eql(0)
      end
    end

    describe "目標指数が 0 でないなら" do
      before do
        @target = 8
      end

      it "目標指数に対する実績値の達成率を取得できること" do
        actual_rate(2, @target, @comparison).should eql(25)
        actual_rate(16, @target, @comparison).should eql(200)
      end
    end
  end

  describe "抑制目標の" do
    before do
      @comparison = @less
      @target = 3
    end

    it "実績値が目標指数以下であれば、達成率 100% を取得できること" do
      actual_rate(2, @target, @comparison).should eql(100)
    end

    it "実績値が目標指数より大きければ、達成率 0% を取得できること" do
      actual_rate(4, @target, @comparison).should eql(0)
    end
  end
end
