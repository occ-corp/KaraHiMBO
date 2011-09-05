# -*- coding: utf-8 -*-
Given /^"(.*)"のメンテナンス画面を表示している$/ do |division|
  d = Division.find_by_name(division)
  get url_for(:controller => :objective, :action => :maintenance,
              :only_path => true), { :id => d.id }
end
