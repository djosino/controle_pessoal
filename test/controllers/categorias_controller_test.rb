require 'test_helper'

class CategoriasControllerTest < ActionController::TestCase
  setup do
    @categoria = categorias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categorias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categoria" do
    assert_difference('Categoria.count') do
      post :create, categoria: { descricao: @categoria.descricao, user_id: @categoria.user_id }
    end

    assert_redirected_to categoria_path(assigns(:categoria))
  end

  test "should show categoria" do
    get :show, id: @categoria
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categoria
    assert_response :success
  end

  test "should update categoria" do
    patch :update, id: @categoria, categoria: { descricao: @categoria.descricao, user_id: @categoria.user_id }
    assert_redirected_to categoria_path(assigns(:categoria))
  end

  test "should destroy categoria" do
    assert_difference('Categoria.count', -1) do
      delete :destroy, id: @categoria
    end

    assert_redirected_to categorias_path
  end
end
