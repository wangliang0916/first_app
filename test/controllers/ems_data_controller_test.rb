require 'test_helper'

class EmsDataControllerTest < ActionController::TestCase
  setup do
    @ems_datum = ems_data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ems_data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ems_datum" do
    assert_difference('EmsDatum.count') do
      post :create, ems_datum: { tagname: @ems_datum.tagname, value: @ems_datum.value }
    end

    assert_redirected_to ems_datum_path(assigns(:ems_datum))
  end

  test "should show ems_datum" do
    get :show, id: @ems_datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ems_datum
    assert_response :success
  end

  test "should update ems_datum" do
    patch :update, id: @ems_datum, ems_datum: { tagname: @ems_datum.tagname, value: @ems_datum.value }
    assert_redirected_to ems_datum_path(assigns(:ems_datum))
  end

  test "should destroy ems_datum" do
    assert_difference('EmsDatum.count', -1) do
      delete :destroy, id: @ems_datum
    end

    assert_redirected_to ems_data_path
  end
end
