# app/graphql/mutations/create_ingredient.rb
module Mutations
  class CreateIngredient < BaseMutation
    # Define input fields
    argument :title, String, required: true
    # Add other fields as necessary

    field :name, String, null: false
    field :errors, [String], null: false

    def resolve(name:)
      ingredient = Ingredient.new(name:)
      # Add handling for other fields

      if ingredient.save
        {
          ingredient:,
          errors: []
        }
      else
        {
          ingredient: nil,
          errors: ingredient.errors.full_messages
        }
      end
    end
  end
end
