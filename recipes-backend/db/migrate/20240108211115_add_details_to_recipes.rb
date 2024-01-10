class AddDetailsToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :prep_time, :string
    add_column :recipes, :cook_time, :string
    add_column :recipes, :total_time, :string
    add_column :recipes, :difficulty, :string
    add_column :recipes, :rate, :string
    add_column :recipes, :people_quantity, :integer
    add_column :recipes, :image, :string
    add_column :recipes, :author, :string
    add_column :recipes, :nb_comments, :integer
  end
end
