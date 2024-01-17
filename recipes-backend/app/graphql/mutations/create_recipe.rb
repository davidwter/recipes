# app/graphql/mutations/create_recipe.rb
module Mutations
    class CreateRecipe < BaseMutation
      # Define input fields
      argument :title, String, required: true
      # Add other fields as necessary
  
      field :recipe, Types::RecipeType, null: false
      field :errors, [String], null: false
  
      def resolve(title:)
        recipe = Recipe.new(title: title)
        # Add handling for other fields
  
        if recipe.save
          {
            recipe: recipe,
            errors: []
          }
        else
          {
            recipe: nil,
            errors: recipe.errors.full_messages
          }
        end
      end
    end
  end
  