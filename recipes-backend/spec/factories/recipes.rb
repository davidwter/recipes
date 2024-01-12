FactoryBot.define do
    factory :recipe do
      title { "Tomato Soup" }
      instructions { "Mix ingredients and cook for 20 minutes." }
      # Add other fields as necessary, like prep_time, cook_time, etc.
      after(:create) do |recipe|
        create_list(:ingredient, 3, recipes: [recipe])
        # This creates 3 ingredients and associates them with the recipe.
      end
    end
  end
  