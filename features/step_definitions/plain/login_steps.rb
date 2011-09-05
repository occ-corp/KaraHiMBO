# -*- coding: utf-8 -*-
Given /^"(.*)"でログインしている$/ do |name|
  u = Employee.find_by_name(name).user
  post "/session", { :login => u.login, :password => "tteesstt" }
  @user = u
  controller.current_user
end

Given /^ログインしていない$/ do
  log_out
end

Then /^ログアウトする$/ do
  log_out
end

def log_out
  get url_for :controller => :sessions, :action => :destroy
  response.should be_redirect
  response.should redirect_to :controller => :objective
end
