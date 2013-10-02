class CategoriasController < ApplicationController
  before_action :set_categoria, only: [:show, :edit, :update, :destroy]

  # GET /categorias
  # GET /categorias.json
  def index
    @categoria = Categoria.new
    @categorias = Categoria.all.where("user_id is null or user_id = ?", current_user).order("tipo_lancamento_id asc, descricao asc")
    @tipos_lancamento = TipoLancamento.all
  end

  # GET /categorias/1
  # GET /categorias/1.json
   def show
      @sub_categoria = SubCategoria.new
      @sub_categorias = []
      if @categoria.sub_categorias.any?
         @sub_categorias = @categoria.sub_categorias.order("descricao asc")
      end
   end

  # GET /categorias/new
  def new
    @categoria = Categoria.new
  end

  # GET /categorias/1/edit
  def edit
    @tipos_lancamento = TipoLancamento.all
  end

  # POST /categorias
  # POST /categorias.json
  def create
    @categoria = Categoria.new(categoria_params)
    @categoria.user = current_user
    respond_to do |format|
      if @categoria.save
        format.html { redirect_to categorias_url, notice: 'Categoria criada com sucesso.'  }
        format.json { render action: 'show', status: :created, location: @categoria }
      else
        @categorias = Categoria.all.where("user_id is null or user_id = ?", current_user).order("tipo_lancamento_id asc, descricao asc")
        @tipos_lancamento = TipoLancamento.all
        format.html { render action: 'index' }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categorias/1
  # PATCH/PUT /categorias/1.json
  def update
    @categoria.user = current_user
    @categoria.save
    respond_to do |format|
      if @categoria.update(categoria_params)
        format.html { redirect_to categorias_url, notice: 'Categoria atualizada com sucesso.' }
        format.json { head :no_content }
      else
        @categorias = Categoria.all
        @tipos_lancamento = TipoLancamento.all
        format.html { render action: 'edit' }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categorias/1
  # DELETE /categorias/1.json
  def destroy
    begin
      @categoria.destroy
    rescue ActiveRecord::DeleteRestrictionError 
      flash[:error] = "Não é possível remover categoria que possua lançamentos."
    end    
    respond_to do |format|
      format.html { redirect_to categorias_url }
      format.json { head :no_content }
    end
  end

  def por_tipo
     @categorias = []
     if params[:tipo_lancamento_id].present?
        @categorias = Categoria.where(["tipo_lancamento_id = ? and (user_id is null or user_id = ?)", params[:tipo_lancamento_id], current_user.id])
     end
     render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categoria
      @categoria = Categoria.where("id = ? and user_id = ?", params[:id], current_user.id).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categoria_params
      params.require(:categoria).permit(:user_id, :descricao, :tipo_lancamento_id)
    end
end
