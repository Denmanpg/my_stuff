class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # GET /products
  # GET /products.json
  def index
    @categories=Category.all
    case params[:filter]
    when "personal"
      @products=Product.where(user_id: current_user.id)
    when "categorical"
      @products=Product.all
      @category=Category.find(params[:cat_id])
      @products_of_cat=[]
      @products.each do|product|
        if product.category.id==params[:cat_id].to_i
          @products_of_cat.push(product)
        end
      end
      @products=@products_of_cat
    when "friends"
      @friends=current_user.active_friends
      @products=Product.where.not(user_id: current_user.id)
      @products_by_friend=[]
      @products.each do |product|
        @friends.each do|friend|
          if friend==product.user||friend==product.user
            @products_by_friend.push(product)
          end
        end
      end
      @products=@products_by_friend
    else
      @products = Product.all
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @message=Message.new
  end

  # GET /products/new
  def new
    @product = Product.new
    @categories=Category.all
  end

  # GET /products/1/edit
  def edit
    @categories=Category.all
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :category_id, :user_id,:image)
    end
end
