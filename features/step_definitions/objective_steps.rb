Given /^the following objectives:$/ do |objectives|
  Objective.create!(objectives.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) objective$/ do |pos|
  visit objectives_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following objectives:$/ do |expected_objectives_table|
  expected_objectives_table.diff!(table_at('table').to_a)
end
