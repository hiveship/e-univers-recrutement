require 'test_helper'

class CandidaturesControllerTest < ActionController::TestCase
  setup do
    @candidature = candidatures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:candidatures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create candidature" do
    assert_difference('Candidature.count') do
      post :create, candidature: { candidature_bornDate: @candidature.candidature_bornDate, candidature_date: @candidature.candidature_date, candidature_mail: @candidature.candidature_mail, candidature_motivation: @candidature.candidature_motivation, candidature_pseudo: @candidature.candidature_pseudo, candidature_result: @candidature.candidature_result }
    end

    assert_redirected_to candidature_path(assigns(:candidature))
  end

  test "should show candidature" do
    get :show, id: @candidature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @candidature
    assert_response :success
  end

  test "should update candidature" do
    patch :update, id: @candidature, candidature: { candidature_bornDate: @candidature.candidature_bornDate, candidature_date: @candidature.candidature_date, candidature_mail: @candidature.candidature_mail, candidature_motivation: @candidature.candidature_motivation, candidature_pseudo: @candidature.candidature_pseudo, candidature_result: @candidature.candidature_result }
    assert_redirected_to candidature_path(assigns(:candidature))
  end

  test "should destroy candidature" do
    assert_difference('Candidature.count', -1) do
      delete :destroy, id: @candidature
    end

    assert_redirected_to candidatures_path
  end
end
