require "test_helper"

class SupplierCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplier_category = supplier_categories(:one)
  end

  test "should get index" do
    get supplier_categories_url, as: :json
    assert_response :success
  end

  test "should create supplier_category" do
    assert_difference("SupplierCategory.count") do
      post supplier_categories_url, params: { supplier_category: { name: @supplier_category.name } }, as: :json
    end

    assert_response :created
  end

  test "should show supplier_category" do
    get supplier_category_url(@supplier_category), as: :json
    assert_response :success
  end

  test "should update supplier_category" do
    patch supplier_category_url(@supplier_category), params: { supplier_category: { name: @supplier_category.name } }, as: :json
    assert_response :success
  end

  test "should destroy supplier_category" do
    assert_difference("SupplierCategory.count", -1) do
      delete supplier_category_url(@supplier_category), as: :json
    end

    assert_response :no_content
  end
end
