# frozen_string_literal: true
# This magic comment is used to enforce string immutability across the file which improves performance by reducing object allocations.
require 'byebug'
# app/controllers/ingredients_controller.rb
# Purpose: Controller for the ingredients resource.
# This file defines the IngredientsController, handling web requests related to ingredients in the application.

class IngredientsController  < ApplicationController
  # Inherits from ApplicationController to leverage common functionality across controllers.

  def index
    @ingredients = Ingredient.all
    render json: @ingredients
    # Retrieves all ingredients from the database to display them in the index view.
    # This is typically used to list all available ingredients.
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    render json: @ingredient
    # Finds a single ingredient by its ID, which is useful for displaying details of a specific ingredient.
    # This action is typically triggered when a user wants to view more information about an ingredient.
  end

  def new
    @ingredient = Ingredient.new
    render json: @ingredient
    # Initializes a new ingredient object to be used in the creation form.
    # This action prepares the form where a user can input data for a new ingredient.
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    # Creates a new ingredient instance with the parameters received from the form.
    # It is a standard way to handle form submissions and create new records in the database.
    if @ingredient.save
      render json: @ingredient, status: :created
      # Redirects to the show page of the newly created ingredient if saved successfully, providing user feedback.
    else
      render json: @ingredient.errors, status: :unprocessable_entity
      # Re-renders the 'new' template to display errors if the ingredient fails to save.
      # This helps the user correct their input without losing the data they've already entered.
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
    # Strong parameters method: ensures that only the permitted fields (in this case, 'name') can be mass-assigned.
    # This is a security practice to prevent unwanted attributes from being saved and to ensure data integrity.
  end
end
