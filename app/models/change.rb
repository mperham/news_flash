class Change < ActiveRecord::Base
  def self.since(time)
    where('created_at > ?', time).order('created_at DESC').limit(5)
  end
end
