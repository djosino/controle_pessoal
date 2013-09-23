require 'test_helper'

class RotinasControllerTest < ActionController::TestCase
  setup do
    @rotina = rotinas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rotinas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rotina" do
    assert_difference('Rotina.count') do
      post :create, rotina: { ativo: @rotina.ativo, categoria_id: @rotina.categoria_id, data_final: @rotina.data_final, data_inicial: @rotina.data_inicial, data_pagamento: @rotina.data_pagamento, data_vencimento: @rotina.data_vencimento, descricao: @rotina.descricao, tipo_lancamento_id: @rotina.tipo_lancamento_id, user_id: @rotina.user_id, valor: @rotina.valor }
    end

    assert_redirected_to rotina_path(assigns(:rotina))
  end

  test "should show rotina" do
    get :show, id: @rotina
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rotina
    assert_response :success
  end

  test "should update rotina" do
    patch :update, id: @rotina, rotina: { ativo: @rotina.ativo, categoria_id: @rotina.categoria_id, data_final: @rotina.data_final, data_inicial: @rotina.data_inicial, data_pagamento: @rotina.data_pagamento, data_vencimento: @rotina.data_vencimento, descricao: @rotina.descricao, tipo_lancamento_id: @rotina.tipo_lancamento_id, user_id: @rotina.user_id, valor: @rotina.valor }
    assert_redirected_to rotina_path(assigns(:rotina))
  end

  test "should destroy rotina" do
    assert_difference('Rotina.count', -1) do
      delete :destroy, id: @rotina
    end

    assert_redirected_to rotinas_path
  end
end
