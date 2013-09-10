class CategoriaController < ApplicationController
  before_action :set_categorium, only: [:show, :edit, :update, :destroy]

  # GET /categoria
  # GET /categoria.json
  def index
    @categoria = Categorium.all
  end

  # GET /categoria/1
  # GET /categoria/1.json
  def show
  end

  # GET /categoria/new
  def new
    @categorium = Categorium.new
  end

  # GET /categoria/1/edit
  def edit
  end

  # POST /categoria
  # POST /categoria.json
  def create
    @categorium = Categorium.new(categorium_params)

    respond_to do |format|
      if @categorium.save
        format.html { redirect_to @categorium, notice: 'Categorium was successfully created.' }
        format.json { render action: 'show', status: :created, location: @categorium }
      else
        format.html { render action: 'new' }
        format.json { render json: @categorium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categoria/1
  # PATCH/PUT /categoria/1.json
  def update
    respond_to do |format|
      if @categorium.update(categorium_params)
        format.html { redirect_to @categorium, notice: 'Categorium was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @categorium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categoria/1
  # DELETE /categoria/1.json
  def destroy
    @categorium.destroy
    respond_to do |format|
      format.html { redirect_to categoria_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categorium
      @categorium = Categorium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categorium_params
      params.require(:categorium).permit(:user_id, :descricao)
    end
end
