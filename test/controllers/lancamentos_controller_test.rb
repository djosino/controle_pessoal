require 'test_helper'

class LancamentosControllerTest < ActionController::TestCase
  setup do
    @lancamento = lancamentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lancamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lancamento" do
    assert_difference('Lancamento.count') do
      post :create, lancamento: { categoria_id: @lancamento.categoria_id, data_pagamento: @lancamento.data_pagamento, data_vencimento: @lancamento.data_vencimento, tipo_lancamento_id: @lancamento.tipo_lancamento_id, user_id: @lancamento.user_id, valor: @lancamento.valor }
    end

    assert_redirected_to lancamento_path(assigns(:lancamento))
  end

  test "should show lancamento" do
    get :show, id: @lancamento
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lancamento
    assert_response :success
  end

  test "should update lancamento" do
    patch :update, id: @lancamento, lancamento: { categoria_id: @lancamento.categoria_id, data_pagamento: @lancamento.data_pagamento, data_vencimento: @lancamento.data_vencimento, tipo_lancamento_id: @lancamento.tipo_lancamento_id, user_id: @lancamento.user_id, valor: @lancamento.valor }
    assert_redirected_to lancamento_path(assigns(:lancamento))
  end

  test "should destroy lancamento" do
    assert_difference('Lancamento.count', -1) do
      delete :destroy, id: @lancamento
    end

    assert_redirected_to lancamentos_path
  end
end
