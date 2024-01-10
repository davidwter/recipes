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
      ingredients = parse_ingredients(params[:ingredients])
      @recipes = fetch_matching_recipes(ingredients)
      render json: format_recipes_json(@recipes, ingredients)
    else
      render json: Recipe.all
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :instructions, :prep_time, :cook_time, :total_time, :difficulty, :rate,
                                   :people_quantity, :image, :author, :nb_comments)
  end

  def parse_ingredients(ingredients_param)
    ingredients_param.split(',').map(&:strip)
  end

  def fetch_matching_recipes(ingredients)
    Recipe.joins(:ingredients)
          .select('recipes.*, COUNT(ingredients.id) AS matching_ingredients_count')
          .where(build_ingredients_query(ingredients), *build_query_values(ingredients))
          .group('recipes.id')
          .order('matching_ingredients_count DESC')
          .distinct
  end

  def build_ingredients_query(ingredients)
    ingredients.map { 'ingredients.name ILIKE ?' }.join(' OR ')
  end

  def build_query_values(ingredients)
    ingredients.map { |ingredient| "%#{ingredient}%" }
  end

  def format_recipes_json(recipes, ingredients)
    recipes.map do |recipe|
      matching_ingredients = fetch_matching_ingredients(recipe, ingredients)
      recipe_json(recipe, matching_ingredients)
    end
  end

  def fetch_matching_ingredients(recipe, ingredients)
    recipe.ingredients.where(
      build_ingredients_query(ingredients),
      *build_query_values(ingredients)
    ).pluck(:name)
  end

  def recipe_json(recipe, matching_ingredients)
    {
      id: recipe.id,
      name: recipe.title,
      matching_ingredients_count: recipe.matching_ingredients_count,
      matching_ingredients: matching_ingredients
    }
  end
end
