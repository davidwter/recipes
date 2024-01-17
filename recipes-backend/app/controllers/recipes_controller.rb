# app/controllers/recipes_controller.rb
class RecipesController < ApplicationController
  # Inherits from ApplicationController, providing a set of common behaviors for handling HTTP requests.

  # GET /recipes
  def index
    @recipes = Recipe.all
    # Retrieves all recipes. Useful for listing recipes in a general view or API endpoint.
    render json: @recipes
    # Responds with a JSON representation of all recipes, making this method suitable for API consumption.
  end

  # GET /recipes/:id
  def show
    @recipe = Recipe.includes(:ingredients).find(params[:id])
    # Fetches a single recipe along with its associated ingredients to reduce database queries.
    # This method is typically used for showing detailed information about a specific recipe.
    render json: @recipe.as_json(include: :ingredients)
    # Renders the recipe and its ingredients as JSON, providing a detailed view of the recipe.
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    # Initializes a new recipe instance with the provided parameters.
    # This is part of the standard create action in Rails for processing form data for new records.
    if @recipe.save
      render json: @recipe, status: :created
      # Sends a JSON response with the created recipe and HTTP status code indicating successful creation.
    else
      render json: @recipe.errors, status: :unprocessable_entity
      # If the recipe fails to save, responds with the validation errors and an appropriate HTTP status code.
    end
  end

  # GET /recipes/search?ingredients=...
  def search
    if params[:ingredients].present?
      ingredients = parse_ingredients(params[:ingredients])
      page = params[:page] || 1
      per_page = params[:per_page] || 10
      # Processes the search parameter to extract individual ingredients.
      @recipes = fetch_matching_recipes(ingredients).page(page).per(per_page)
      # Retrieves recipes matching the given ingredients.
      render json: {
        recipes: format_recipes_json(@recipes, ingredients),
        total_pages: @recipes.total_pages,
        current_page: @recipes.current_page
      }
    else
      # Handle default case with pagination
      @recipes = Recipe.page(params[:page]).per(10)
      render json: {
        recipes: format_recipes_json(@recipes, ingredients),
        total_pages: @recipes.total_pages,
        current_page: @recipes.current_page
      }
    end
  end

  private

  # Below are the private methods used internally by this controller.

  def recipe_params
    # Defines the parameters allowed for creating/updating recipes, a security practice known as strong parameters.
    params.require(:recipe).permit(:title, :instructions, :prep_time, :cook_time, :total_time, :difficulty, :rate,
                                   :people_quantity, :image, :author, :nb_comments)
  end

  # Following methods support the search functionality by parsing and querying ingredients.

  def parse_ingredients(ingredients_param)
    # Splits the ingredient parameter into individual ingredients and trims any whitespace.
    ingredients_param.split(',').map(&:strip)
  end

  def fetch_matching_recipes(ingredients)
    # Forms a query to find recipes with the highest count of matching ingredients.
    # This approach optimizes the relevance of search results.
    Recipe.joins(:ingredients)
          .select('recipes.id,recipes.title, COUNT(ingredients.id) AS matching_ingredients_count')
          .where(build_ingredients_query(ingredients), *build_query_values(ingredients))
          .group('recipes.id')
          .order('matching_ingredients_count DESC')
          .distinct
  end

  def build_ingredients_query(ingredients)
    # Constructs a dynamic query based on the number of ingredients, allowing for flexible search criteria.
    ingredients.map { 'ingredients.name ILIKE ?' }.join(' OR ')
  end

  def build_query_values(ingredients)
    # Prepares the values for the SQL query, using a LIKE operation for partial matches.
    ingredients.map { |ingredient| "%#{ingredient}%" }
  end

  def format_recipes_json(recipes, ingredients)
    # Formats the search results as JSON, enhancing the response structure for the frontend or API consumers.
    # This method is tailored to highlight the matching ingredients in each recipe.
    recipes.map do |recipe|
      matching_ingredients = fetch_matching_ingredients(recipe, ingredients)
      # Retrieves the specific ingredients that matched the search query for each recipe.
      recipe_json(recipe, matching_ingredients)
      # Constructs a JSON representation for each recipe including the count and names of matching ingredients.
    end
  end

  def fetch_matching_ingredients(recipe, ingredients)
    # Queries the database to find the exact ingredients from the search query that are present in each recipe.
    # This adds value by showing users exactly which of their ingredients are used in each recipe.
    recipe.ingredients.where(
      build_ingredients_query(ingredients),
      *build_query_values(ingredients)
    ).pluck(:name)
    # Plucks only the names of the matching ingredients, optimizing the query for performance and relevance.
  end

  def recipe_json(recipe, matching_ingredients)
    # Custom method to format the recipe data into a structured JSON format.
    # This method allows for a consistent data structure across different endpoints and makes the API more predictable.
    {
      id: recipe.id,
      name: recipe.title,
      matching_ingredients_count: recipe.matching_ingredients_count,
      matching_ingredients:
      # The JSON structure includes essential recipe details along with the count and names of ingredients
      # that matched the search criteria, providing a comprehensive and user-friendly data representation.
    }
  end
end
