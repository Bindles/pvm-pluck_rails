#vape_products.controller.rb
class VapeProductsController < ApplicationController
  before_action :set_vape_product, only: %i[ show edit update destroy ]

  # GET /vape_products or /vape_products.json
  def index
    @vape_products = VapeProduct.all
    @products_by_category = VapeProduct.order(:category)
    @categories = VapeProduct.pluck(:category).uniq
    session[:valid_categories] = @categories
  end

  def show_category
    @category = params[:category]
    if session[:valid_categories].include?(@category)
      @products = VapeProduct.where(category: @category)
    else
      redirect_to vape_products_path
    end
  end

  def show_categoryz
    @category = params[:category]
    @products = VapeProduct.where(category: @category)
    if @products.empty?
      redirect_to vape_products_path
    end
    
  end

  def layout
    @vape_products = VapeProduct.all

  end
  def layout2
    @vape_products = VapeProduct.all

  end
  def layout3
    @vape_products = VapeProduct.all
  end

  # GET /vape_products/1 or /vape_products/1.json
  def show
  end

  # GET /vape_products/new
  def new
    @vape_product = VapeProduct.new
  end

  # GET /vape_products/1/edit
  def edit
  end

  # POST /vape_products or /vape_products.json
  def create
    @vape_product = VapeProduct.new(vape_product_params)

    respond_to do |format|
      if @vape_product.save
        format.html { redirect_to vape_product_url(@vape_product), notice: "Vape product was successfully created." }
        format.json { render :show, status: :created, location: @vape_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vape_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vape_products/1 or /vape_products/1.json
  def update
    respond_to do |format|
      if @vape_product.update(vape_product_params)
        format.html { redirect_to vape_product_url(@vape_product), notice: "Vape product was successfully updated." }
        format.json { render :show, status: :ok, location: @vape_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vape_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vape_products/1 or /vape_products/1.json
  def destroy
    @vape_product.destroy!

    respond_to do |format|
      format.html { redirect_to vape_products_url, notice: "Vape product was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def export
    @vape_products = VapeProduct.all
    respond_to do |format|
      format.html
      format.csv { send_data @vape_products.to_csv, filename: "vape_products-#{Date.today}.csv" }
    end
  end
  
  def import
    import_option_skip = params[:import_option_skip] == '1'
    import_option_update = params[:import_option_update] == '1'
    import_option_error = params[:import_option_error] == '1'

    begin
      VapeProduct.import(params[:file], import_option_skip, import_option_update, import_option_error)
      redirect_to vape_products_path, notice: "Vape Products imported successfully."
    rescue StandardError => e
      redirect_to vape_products_path, alert: "Error importing Vape Products: #{e.message}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vape_product
      @vape_product = VapeProduct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vape_product_params
      params.require(:vape_product).permit(:name, :price, :desc, :category)
    end
end
