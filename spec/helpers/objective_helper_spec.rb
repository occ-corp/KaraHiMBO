# -*- coding: utf-8 -*-
require 'spec_helper'

describe ObjectiveHelper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(ObjectiveHelper)
  end

  describe "#current_period が呼ばれた時" do
    it "year に対する期数を返す" do
      helper.current_period(2009).should eql(44)
    end
  end

  describe "#period_name が呼ばれたとき" do
    it "引数が無ければ nil を返す" do
      helper.period_name(nil).should == nil
    end

    it "引数があれば 年度と期の文字列を返す" do
      helper.period_name(2009).should =~ /2009.*年度.*44.*期/
    end
  end
end
