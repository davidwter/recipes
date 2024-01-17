# spec/controllers/ingredients_controller_spec.rb

require 'rails_helper'
require 'byebug'

RSpec.describe Ingredient, type: :model do
    it "has a valid factory" do
      ingredient = build(:ingredient)
      expect(ingredient).to be_valid
    end
end


RSpec.describe IngredientsController, type: :controller do
  it "should get index" do
    get :index
    expect(response).to have_http_status(:success)
  end 
end