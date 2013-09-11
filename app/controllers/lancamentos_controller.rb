class LancamentosController < ApplicationController
  before_action :set_lancamento, only: [:show, :edit, :update, :destroy]
  before_action :get_selects, only: [:new, :edit, :update, :create]

  # GET /lancamentos
  # GET /lancamentos.json
  def index
    @lancamentos = Lancamento.all
  end

  # GET /lancamentos/1
  # GET /lancamentos/1.json
  def show
  end

  # GET /lancamentos/new
  def new
    @lancamento = Lancamento.new
  end

  # GET /lancamentos/1/edit
  def edit
  end

  # POST /lancamentos
  # POST /lancamentos.json
  def create
    @lancamento = Lancamento.new(lancamento_params)
    @lancamento.user = current_user
    respond_to do |format|
      if @lancamento.save
        format.html { redirect_to @lancamento, notice: 'Lancamento was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lancamento }
      else
        format.html { render action: 'new' }
        format.json { render json: @lancamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lancamentos/1
  # PATCH/PUT /lancamentos/1.json
  def update
    @lancamento.user = current_user
    respond_to do |format|
      if @lancamento.update(lancamento_params)
        format.html { redirect_to @lancamento, notice: 'Lancamento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lancamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lancamentos/1
  # DELETE /lancamentos/1.json
  def destroy
    @lancamento.destroy if @lancamento.user == current_user 
    respond_to do |format|
      format.html { redirect_to lancamentos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lancamento
      @lancamento = Lancamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lancamento_params
      params.require(:lancamento).permit(:descricao, :data_vencimento, :data_pagamento, :valor, :tipo_lancamento_id, :categoria_id, :user_id)
    end

    def get_selects
       @tipos_lancamento = TipoLancamento.all
       @categorias       = current_user.categorias
    end
end
