require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let!(:recipe) { Recipe.create(title: 'Test Recipe', instructions: 'Some instructions') }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(json).to eq([recipe].as_json)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: recipe.to_param }
      expect(response).to be_successful
      expect(json).to eq(recipe.as_json)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Recipe' do
        expect do
          post :create, params: { recipe: valid_attributes }
        end.to change(Recipe, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns a failure response' do
        post :create, params: { recipe: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'Updated Title' } }

      it 'updates the requested recipe' do
        put :update, params: { id: recipe.to_param, recipe: new_attributes }
        recipe.reload
        expect(recipe.title).to eq('Updated Title')
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      it 'returns a failure response' do
        put :update, params: { id: recipe.to_param, recipe: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested recipe' do
      expect do
        delete :destroy, params: { id: recipe.to_param }
      end.to change(Recipe, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #search' do
    let!(:ingredient1) { Ingredient.create(name: 'Tomato') }
    let!(:ingredient2) { Ingredient.create(name: 'Cheese') }
    let!(:recipe1) { Recipe.create(title: 'Tomato Pasta', ingredients: [ingredient1]) }
    let!(:recipe2) { Recipe.create(title: 'Cheese Pizza', ingredients: [ingredient2]) }
    let!(:recipe3) { Recipe.create(title: 'Tomato and Cheese Salad', ingredients: [ingredient1, ingredient2]) }

    it 'returns recipes that match the provided ingredients' do
      get :search, params: { ingredients: 'Tomato, Cheese' }
      expect(response).to be_successful
      expect(json.map { |r| r['id'] }).to match_array([recipe3.id])
    end

    it 'returns no recipes if none match the provided ingredients' do
      get :search, params: { ingredients: 'Chicken' }
      expect(response).to be_successful
      expect(json).to be_empty
    end
  end
end
