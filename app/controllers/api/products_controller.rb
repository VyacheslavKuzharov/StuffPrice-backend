class Api::ProductsController < ApplicationController

  def index
    products = Product.all.order(created_at: :desc)
    products = products.page(params[:page]).per(20)

    respond_to do |format|
      format.json {render json: products.map{ |product| product.as_json.merge(
                     categories: product.categories.map(&:name),
                     contact: {name: product.user.name, phone: product.user.phone, email: product.user.email}
                  )}}
    end
  end

  def create
    product = Product.create(product_params.except('selectedCategories'))
    product_categories = product.categories

    params[:product][:selectedCategories].each do |category_name|
      category = Category.find_by_name category_name
      category = product_categories.create(name: category_name) unless category

      product_categories << category unless product_categories.include? category
    end

    respond_to do |format|
      format.json {render json: product.as_json.merge(
          categories: product_categories,
          contact: {name: product.user.name, phone: product.user.phone, email: product.user.email}
      )}
    end
  end

  def update
    product = Product.find_by_id params[:product][:id]
    product.update_attributes(product_params)

    respond_to do |format|
      format.json {render json: product}
    end
  end

  def destroy
    product = Product.find_by_id params[:id]
    product.destroy

    respond_to do |format|
      format.json {render json: {success: true}}
    end
  end

  private

  def product_params
    params.require(:product).permit(:title,
                                    :price,
                                    :description,
                                    :image,
                                    :selectedCategories,
                                    :user_id,
                                    :id,
                                    :views,
                                    :created_at,
                                    :updated_at
    ) ## Rails 4 strong params usage
  end
end
