require 'rails_helper'

RSpec.describe Ingredient, type: :model do
   # Test for validations
   describe 'validations' do
    it 'is valid with valid attributes' do
      ingredient = Ingredient.new(name: 'Tomato')
      expect(ingredient).to be_valid
    end

    it 'is not valid without a name' do
      ingredient = Ingredient.new(name: nil)
      expect(ingredient).not_to be_valid
    end
  end

  # Test for associations
  describe 'associations' do
    it { should have_many(:recipe_ingredients) }
    it { should have_many(:recipes).through(:recipe_ingredients) }
  end
end
