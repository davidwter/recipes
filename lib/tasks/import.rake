# lib/tasks/import.rake
require 'ruby-progressbar'
namespace :db do
    desc "Import recipes from a JSON file"
    task import_recipes: :environment do
      # Drop and recreate the database
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
  
      file_path = 'lib/assets/Modified_recipes.json' # Ensure correct file path
      file = File.read(file_path)
      recipes = JSON.parse(file)

      # Create a new progress bar
    progress_bar = ProgressBar.create(
        title: "Importing Recipes",
        total: recipes.size,
        format: '%a |%b>>%i| %p%% %t'
      )
  
  
      recipes.each do |recipe_data|
        recipe = Recipe.create(
          title: recipe_data['name'],
          instructions: recipe_data['author_tip'], # Assuming 'author_tip' contains instructions
          prep_time: recipe_data['prep_time'],
          cook_time: recipe_data['cook_time'],
          total_time: recipe_data['total_time'],
          difficulty: recipe_data['difficulty'],
          rate: recipe_data['rate'],
          people_quantity: recipe_data['people_quantity'],
          image: recipe_data['image'],
          author: recipe_data['author'],
          nb_comments: recipe_data['nb_comments']
        )
      
        recipe_data['ingredients'].each do |ingredient_string|
          ingredient = Ingredient.find_or_create_by(name: ingredient_string)
          RecipeIngredient.create(recipe: recipe, ingredient: ingredient)
        end
        progress_bar.increment
      end
    end
  end
  