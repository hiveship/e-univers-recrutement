require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users" do
    assert_difference('User.count') do
      post :create, users: { login: @user.login, mail: @user.mail, pass: @user.pass, state: @user.state, status: @user.status }
    end

    assert_redirected_to user_path(assigns(:users))
  end

  test "should show users" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update users" do
    patch :update, id: @user, users: { login: @user.login, mail: @user.mail, pass: @user.pass, state: @user.state, status: @user.status }
    assert_redirected_to user_path(assigns(:users))
  end

  test "should destroy users" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
