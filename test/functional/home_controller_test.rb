require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :redirect
  end

  test 'logged in user should see index' do
    login_bob
    get :index
    assert_response :success
    assert_no_tag :div, :attributes => { :id => "news" }
  end

  test 'logged in user should see changes' do
    Change.create! :link => 'x', :title => 'Big news!'
    login_bob
    get :index
    assert_response :success
    assert_tag :div, :attributes => { :id => "news" }
    assert_tag :tag => "div",
             :descendant => { :tag => "li" }
  end

  test 'marking as read removes news' do
    Change.create! :link => 'x', :title => 'Big news!'
    u = login_bob
    get :index
    assert_response :success
    assert_tag :div, :attributes => { :id => "news" }
    assert_nil u.last_read_at

    post :mark_as_read
    u.reload
    assert_not_nil u.last_read_at

    get :index
    assert_response :success
    assert_no_tag :div, :attributes => { :id => "news" }

    Change.create! :link => 'x', :title => 'Small news.'

    get :index
    assert_response :success
    assert_tag :div, :attributes => { :id => "news" }
    assert_match /Small/, response.body
  end

  def login_bob
    u = User.create! :email => 'mike@perham.net', :password => 'pass'
    login_user(u)
    u
  end

end
