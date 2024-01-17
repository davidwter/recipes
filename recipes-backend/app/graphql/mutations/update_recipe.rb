# app/graphql/mutations/update_recipe.rb
module Mutations
  class UpdateRecipe < BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: true
    # Add other fields as necessary for updating a recipe
    field :recipe, Types::RecipeType, null: false
    field :errors, [String], null: false

    def resolve(id:, title:)
      recipe = Recipe.find(id)
      if recipe.update(title:)
        # Add handling for other fields
        {
          recipe:,
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
