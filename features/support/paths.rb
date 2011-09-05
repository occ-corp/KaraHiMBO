# -*- coding: utf-8 -*-
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    when /the new objective page/
      new_objective_path
    when /the new users page/
      new_users_path
    when /ログイン/
      new_session_path
    when /トップ/
      root_path
    when /メンテナンス画面/
      url_for(:controller => :objective, :action => :maintenance,
              :only_path => true)
    when /エクスポート画面/
      url_for(:controller => :objective, :action => :export,
              :only_path => true)
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
