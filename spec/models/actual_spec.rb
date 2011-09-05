# -*- coding: utf-8 -*-
require 'spec_helper'

describe Actual do
  fixtures :actuals

  before do
    @attributes = {
      :value => 1, :item_id => 1, :belong_id => 1,
      :year => 2009, :month => 4, :year_month => "200904",
    }
  end

  describe "の attributes が正しい時" do
    before do 
      @actual = Actual.new(@attributes)
    end

    it "バリデーションに成功すること" do
      @actual.should be_valid
    end
  end

  describe "の attributes が足りない時" do
    before do 
      @attributes[:item_id] = nil
      @actual = Actual.new(@attributes)
    end

    it "バリデーションに失敗すること" do
      @actual.should_not be_valid
    end
  end

  describe "#belong_id がマイナスの時" do
    before do 
      @attributes[:belong_id] = -1
      @actual = Actual.new(@attributes)
    end

    it "バリデーションに失敗すること" do
      @actual.should_not be_valid
    end
  end

  describe "#item_id がマイナスの時" do
    before do 
      @attributes[:item_id] = -1
      @actual = Actual.new(@attributes)
    end

    it "バリデーションに失敗すること" do
      @actual.should_not be_valid
    end
  end

  describe "#has_period が呼ばれたとき" do
    it "Actualが存在する年度を取得すること" do
      Actual.has_period.should =~ [2009]
    end
  end

  describe "#has_year が呼ばれたとき" do
    it "Actualが存在する年を取得すること" do
      Actual.has_year.should =~ [2010, 2009]
    end
  end
end
