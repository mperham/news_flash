class HomeController < ApplicationController
  before_filter :require_login

  START_OF_TIME = Time.utc(2000, 1, 1)

  def index
    @changes = Change.since(current_user.last_read_at || START_OF_TIME)
  end

  def mark_as_read
    current_user.update_attribute(:last_read_at, Time.now)
    render :nothing => true
  end

end
