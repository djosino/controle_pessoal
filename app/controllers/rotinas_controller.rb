class RotinasController < ApplicationController
  before_action :set_rotina, only: [:show, :edit, :update, :destroy]
  before_action :get_selects, only: [:new, :edit, :update, :create]

  # GET /rotinas
  # GET /rotinas.json
  def index
    @rotinas = current_user.rotinas
  end

  # GET /rotinas/1
  # GET /rotinas/1.json
  def show
    redirect_to rotinas_path
  end

  # GET /rotinas/new
  def new
    @rotina = Rotina.new
  end

  # GET /rotinas/1/edit
  def edit
  end

  # POST /rotinas
  # POST /rotinas.json
  def create
    @rotina = Rotina.new(rotina_params)
    @rotina.user = current_user
    respond_to do |format|
      if @rotina.save
        format.html { redirect_to rotinas_path, notice: 'Rotina was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rotina }
      else
        format.html { render action: 'new' }
        format.json { render json: @rotina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rotinas/1
  # PATCH/PUT /rotinas/1.json
  def update
    respond_to do |format|
      if @rotina.update(rotina_params)
        format.html { redirect_to rotinas_path, notice: 'Rotina was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rotina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rotinas/1
  # DELETE /rotinas/1.json
  def destroy
    @rotina.destroy
    respond_to do |format|
      format.html { redirect_to rotinas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rotina
      @rotina = Rotina.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rotina_params
      params.require(:rotina).permit(:descricao, :data_vencimento, :data_pagamento, :categoria_id, :tipo_lancamento_id, :user_id, :valor, :data_inicial, :data_final, :ativo)
    end
    def get_selects
       @tipos_lancamento = TipoLancamento.all
       @categorias       = Categoria.where("user_id = ? or user_id is null", current_user)
    end
end
