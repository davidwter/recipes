require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      recipe = Recipe.new(title: 'Test Recipe')
      expect(recipe).to be_valid
    end

    it 'is not valid without a title' do
      recipe = Recipe.new(title: nil)
      expect(recipe).not_to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:recipe_ingredients) }
    it { should have_many(:ingredients).through(:recipe_ingredients) }
  end
end
