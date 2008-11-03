class Recipes < Application

  provides :json

  def index
    display Recipe.all
  end

  def create
    @recipe = Recipe.new(get_params)
    respond(@recipe.save)
  end

  def update
    @recipe = Recipe.get!(params[:id])
    respond(@recipe.update_attributes(get_params))
  end

  def delete
    Recipe.get!(params[:id]).destroy
    display :success => true
  end

  private

  def respond(is_valid)
    is_valid ? respond_with_success : respond_with_failure
  end

  def respond_with_success
    display :success => true  
  end

  def respond_with_failure
    errors = @recipe.errors.collect { |field, msg| { :id => field, :msg => msg } }
    display(:success => false, :errors => errors)
  end

  # Fetch all params that are related with model properties except the id.
  def get_params
    params.dup.delete_if do |key, value|
      key == 'id' or not Recipe.properties.collect { |prop| prop.name }.include?(key.to_sym)
    end
  end

end
