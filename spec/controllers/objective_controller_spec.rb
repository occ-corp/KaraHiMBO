# -*- coding: utf-8 -*-
require 'spec_helper'
include AuthenticatedTestHelper

describe ObjectiveController do
  fixtures :users

  before do
    login_as :data1
    @current_user = User.find(session[:user_id])
  end

  describe "GET 'index'" do
    fixtures :belongs, :employees, :divisions, :posts

    it "should be successful" do
      get :index
      response.should be_success
    end

    describe "で、params[:belong] がない場合" do
      it "自身のデータを表示すること" do
        get :index
        assigns[:employee].should eql(@current_user.employee)
      end
    end

    describe "で、params[:belong] がある時" do
      before do
        @belong = belongs(:data3)
      end

      it "belong に対応する社員データを表示すること" do
        get :index, :belong => @belong.id
        assigns[:employee].should eql Employee.find(@belong.employee)
      end
    end
  end

  describe "employees_live_search" do
    fixtures :divisions, :employees

    before do
      @division = divisions :data1
      get :employees_live_search, :value => @division.id
    end

    it "value で指定された Division に所属する社員を取得できること" do
      assigns[:employees].should =~ Employee.find_by_division_id(@division.id)
    end
    
    it "objective/employee_live_search.html.erb をレンダリングすること" do
      response.should be_success
      response.should render_template("employees_live_search")
    end
  end

  describe "belong_live_search" do
    fixtures :divisions, :employees, :belongs

    before do
      @employee = employees :data1
      @division = divisions :data2
    end

    it "employee があれば、対応する employee, division を取得すること" do
      get :belong_live_search,
          :employee => @employee.id, :division => @division.id
      assigns[:employee].should eql @employee
      assigns[:division].should eql @division
    end

    it "employee がなければ、employee, division は nil になること" do
      get :belong_live_search,
          :employee => nil, :division => @division.id
      assigns[:employee].should eql nil
      assigns[:division].should eql nil

      get :belong_live_search,
          :employee => "", :division => @division.id
      assigns[:employee].should eql nil
      assigns[:division].should eql nil

      get :belong_live_search,
          :employee => "null", :division => @division.id
      assigns[:employee].should eql nil
      assigns[:division].should eql nil
    end
    
    it "objective/belong_live_search.html.erb をレンダリングすること" do
      get :belong_live_search,
          :employee => @employee.id, :division => @division.id
      response.should be_success
      response.should render_template("belong_live_search")
    end
  end

  describe "load が呼び出された時" do
    it "JSON形式でデータを返すこと" do
      pending("waiting")
      post :load
      response.should be_success
    end
  end

  describe "save が呼び出された時" do
    before do 
      @gt_hash = {
        "fieldsName" => ["fiest_category", "second_category", "item", "unit", "entire_index",
                         "person_year_index", "person_month_index",
                         "actual_7", "actual_7_rate","actual_8", "actual_8_rate","actual_9", "actual_9_rate",
                         "actual_10", "actual_10_rate", "actual_11", "actual_11_rate","actual_12", "actual_12_rate",
                         "total", "total_rate"],
        "recordType" => "object",
        "parameters" => {"belong_id" => "4"},
        "updatedFields" => [{ "actual_7" => 1212 }],
        "action" => "save",
        "insertedRecords" => [],
        "updatedRecords" => [{"name" => "入出庫システム販売","created_at" => "2009-11-16 02 => 20 => 45","first_category" => "業務プロセスの視点",
                               "second_category" => "入出庫システムシリーズの拡版","updated_at" => "2009-11-16 02 => 20 => 45","id" => "10","unit" => "個",
                               "entire_index" => "12","comparison_id" => "0","target_index" => "","second_category_id" => "6",
                               "person_year_index" => "2009","person_month_index" => "11","item" => "入出庫システム販売","actual_7" => "1212"
                             }],
        "deletedRecords" => []
      }

      @gt_json = @gt_hash.to_json

      # エラーデータ ["id"] => item_id => item_id が負では保存できない
      @gt_hash["updatedRecords"][0]["id"] = -1
      @gt_json_failure = @gt_hash.to_json
      
      @data = ActiveSupport::JSON.decode(@gt_json)
    end

    # FIXME この判定はかっこわるい。文字直書きとか！
    it "POSTデータが正常であれば 200 コードを返すこと" do
      post(:save, :_gt_json => @gt_json)
      response.should have_text("{ success : true, exception:''}")
    end

    it "POSTデータが正常でなければ 400 コードを返すこと" do
      post(:save, :_gt_json => @gt_json_failure)
      response.should have_text("{ success : false, exception:'更新できませんでした。管理者への報告をお願い致します。'}")
    end
  end
end
