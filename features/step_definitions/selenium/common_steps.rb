# -*- coding: utf-8 -*-
When /^"([^\"]*)"ボタン2をクリックする$/ do |button|
  selenium.click button
  selenium.wait_for_page_to_load
end
