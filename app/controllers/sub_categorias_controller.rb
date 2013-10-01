class SubCategoriasController < ApplicationController
  before_action :set_sub_categoria, only: [:show, :edit, :update, :destroy]

  # GET /sub_categorias
  # GET /sub_categorias.json
  def index
    @sub_categorias = SubCategoria.all
  end

  # GET /sub_categorias/1
  # GET /sub_categorias/1.json
  def show
  end

  # GET /sub_categorias/new
  def new
    @sub_categoria = SubCategoria.new
  end

  # GET /sub_categorias/1/edit
  def edit
  end

  def categoria
     @sub_categorias = []
     if params[:categoria_id].present?
        @sub_categorias = SubCategoria.where(["categoria_id = ? and (user_id is null or user_id = ?)", params[:categoria_id], current_user.id])
     end
     render :layout => false
  end

  # POST /sub_categorias
  # POST /sub_categorias.json
  def create
    @sub_categoria = SubCategoria.new(sub_categoria_params)
    @sub_categoria.user = current_user
    respond_to do |format|
      if @sub_categoria.save
        format.html { redirect_to @sub_categoria.categoria, notice: 'Sub categoria was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sub_categoria }
      else
        format.html { render action: 'new' }
        format.json { render json: @sub_categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_categorias/1
  # PATCH/PUT /sub_categorias/1.json
  def update
    respond_to do |format|
      if @sub_categoria.update(sub_categoria_params)
        format.html { redirect_to @sub_categoria.categoria, notice: 'Sub categoria was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sub_categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_categorias/1
  # DELETE /sub_categorias/1.json
  def destroy
    begin
      @sub_categoria.destroy
    rescue ActiveRecord::DeleteRestrictionError 
      flash[:error] = "Não é possível remover sub-categoria que possua lançamentos."
    end
    respond_to do |format|
      format.html { redirect_to @sub_categoria.categoria }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_categoria
      @sub_categoria = SubCategoria.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_categoria_params
      params.require(:sub_categoria).permit(:descricao, :categoria_id, :user_id)
    end
end
