# coding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)


Role.create(:permission => 1, :name => 'Admin')
Role.create(:permission => 0, :name => 'User')

Comparison.create(:name => '以上を目指す')
Comparison.create(:name => '以下に抑える')
