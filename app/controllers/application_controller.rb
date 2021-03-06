# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  def redirect_to_maintenance(id = nil)
    redirect_to(:controller => :objective, :action => :maintenance, :id => id)
  end
end
