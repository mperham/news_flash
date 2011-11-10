require 'test_helper'

class ChangeTest < ActiveSupport::TestCase

  test "since" do
    Change.create! :link => 'x', :title => 'y'
    Change.create! :link => 'x', :title => 'y'
    assert_equal 2, Change.since(1.minute.ago).size
  end

  test "since results are limited" do
    6.times do
      Change.create! :link => 'x', :title => 'y'
    end
    assert_equal 5, Change.since(1.minute.ago).size
  end

  test "since results returned latest first" do
    6.times do |x|
      Change.create! :link => x.to_s, :title => 'y'
    end
    results = Change.since(1.minute.ago)
    assert_equal 5, results.size
    assert_equal '5', results[0].link
    assert_equal '4', results[1].link
  end

end
