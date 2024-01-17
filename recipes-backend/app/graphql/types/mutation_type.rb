# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    field :create_recipe, mutation: Mutations::CreateRecipe
    field :update_recipe, mutation: Mutations::UpdateRecipe
    field :create_ingredient, mutation: Mutations::CreateIngredient
  

    def test_field
      "Hello World"
    end
  end
end
