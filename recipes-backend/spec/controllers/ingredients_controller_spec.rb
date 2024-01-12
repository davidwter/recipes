# spec/controllers/ingredients_controller_spec.rb

require 'rails_helper'
require 'byebug'

RSpec.describe Ingredient, type: :model do
    it "has a valid factory" do
      ingredient = build(:ingredient)
      expect(ingredient).to be_valid
    end
  end
  
