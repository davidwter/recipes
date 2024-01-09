# app/controllers/recipes_controller.rb
class RecipesController < ApplicationController
  # GET /recipes
  def index
    @recipes = Recipe.all
    render json: @recipes
  end

  # GET /recipes/:id
  def show
    @recipe = Recipe.find(params[:id])
    render json: @recipe.as_json(include: :ingredients)
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipes/:id
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/:id
  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      render json: { message: 'Recipe was successfully destroyed.' }, status: :ok
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # GET /recipes/search?ingredients=...
  def search
    if params[:ingredients].present?
      ingredients = params[:ingredients].split(',').map(&:strip)
      @recipes = Recipe.joins(:ingredients)
                       .select("recipes.*, COUNT(ingredients.id) AS matching_ingredients_count")
                       .where(
                         ingredients.map { "ingredients.name LIKE ?" }.join(' OR '), 
                         *ingredients.map { |ingredient| "%#{ingredient}%" }
                       )
                       .group('recipes.id')
                       .order('matching_ingredients_count DESC')
                       .distinct
  
      @recipes_json = @recipes.map do |recipe|
        matching_ingredients = recipe.ingredients.where(
          ingredients.map { "name LIKE ?" }.join(' OR '), 
          *ingredients.map { |ingredient| "%#{ingredient}%" }
        ).pluck(:name)
  
        {
          id: recipe.id,
          name: recipe.title,
          matching_ingredients_count: recipe.matching_ingredients_count,
          matching_ingredients: matching_ingredients
        }
      end
  
      render json: @recipes_json
    else
      @recipes = Recipe.all
      render json: @recipes
    end
  end
  

  private

  def recipe_params
    params.require(:recipe).permit(:title, :instructions, :prep_time, :cook_time, :total_time, :difficulty, :rate, :people_quantity, :image, :author, :nb_comments)
  end
end
