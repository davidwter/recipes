# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # Query to fetch all ingredients (similar to the index action)
    field :ingredients, [Types::IngredientType], null: false

    def ingredients
      Ingredient.all
    end

    # Query to fetch a single ingredient by ID (similar to the show action)
    field :ingredient, Types::IngredientType, null: true do
      argument :id, ID, required: true
    end

    def ingredient(id:)
      Ingredient.find_by(id:)
    end

    field :recipes, [Types::RecipeType], null: false

    def recipes
      Recipe.all
    end

    # Query to fetch a single recipe by ID (similar to the show action)
    field :recipe, Types::RecipeType, null: true do
      argument :id, ID, required: true
    end

    def recipe(id:)
      Recipe.find_by(id: id)
    end

  end
end
