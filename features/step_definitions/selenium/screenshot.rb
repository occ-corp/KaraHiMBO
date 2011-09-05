# -*- coding: utf-8 -*-
Then /^"(.*)"という名前でエビデンスを取得する$/ do |filename|
  screenshot filename
end

Then /^エビデンスを取得する$/ do
  screenshot Time.now.strftime("%Y%m%d%H%M%S") + ".png"
end

def screenshot(filename = "test.png")
  selenium.capture_entire_page_screenshot File::expand_path(filename), ""
end
