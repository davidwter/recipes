# app/graphql/types/recipe_type.rb
module Types
    class RecipeType < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field :instructions, String, null: true
      field :prep_time, String, null: true
      field :cook_time, String, null: true
      field :total_time, String, null: true
      field :difficulty, String, null: true
      field :rate, String, null: true
      field :image, String, null: true
      field :author, String, null: true
      field :nb_comments, Integer, null: true

      field :ingredients, [Types::IngredientType], null: false
      # This creates a connection to the IngredientType, allowing GraphQL to fetch associated ingredients.
    end
  end
  