require "test_helper"

class SupplierTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplier_type = supplier_types(:one)
  end

  test "should get index" do
    get supplier_types_url, as: :json
    assert_response :success
  end

  test "should create supplier_type" do
    assert_difference("SupplierType.count") do
      post supplier_types_url, params: { supplier_type: { name: @supplier_type.name } }, as: :json
    end

    assert_response :created
  end

  test "should show supplier_type" do
    get supplier_type_url(@supplier_type), as: :json
    assert_response :success
  end

  test "should update supplier_type" do
    patch supplier_type_url(@supplier_type), params: { supplier_type: { name: @supplier_type.name } }, as: :json
    assert_response :success
  end

  test "should destroy supplier_type" do
    assert_difference("SupplierType.count", -1) do
      delete supplier_type_url(@supplier_type), as: :json
    end

    assert_response :no_content
  end
end
