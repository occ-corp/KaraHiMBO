# -*- coding: utf-8 -*-
Given /^"(.*)"でログインしている$/ do |name|
  current_user = Employee.find_by_name(name).user
  visit login_path
  fill_in("login", :with => current_user.login)
  fill_in("password", :with => "tteesstt")
  click_button("Log in")
  selenium.wait_for_page_to_load
  response.body.should =~ /#{name}/m
end

When /^しばらくまつ$/ do
  wait
end

Given /^ログインしていない$/ do
  log_out
end

Then /^ログアウトする$/ do
  log_out
end

def wait(timeout = 2)
  sleep timeout
  selenium.wait_for_ajax
end

def log_out
  get url_for :controller => :sessions, :action => :destroy
end
