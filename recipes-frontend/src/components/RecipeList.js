// src/components/RecipeList.js
import React from 'react';
import { Link } from 'react-router-dom';

const RecipeList = ({ recipes }) => {
  return (
    <table>
      <thead>
        <tr>
          <th>Recette</th>
          <th>Nombre d'ingrédients correspondant</th>
          <th>Ingrédients correspondant</th>
        </tr>
      </thead>
        <tbody>
        {recipes.map((recipe) => (
            <tr key={recipe.id}>
            <td><Link to={`/recipe/${recipe.id}`}>{recipe.name}</Link></td>
            <td>{recipe.matching_ingredients_count}</td>
            <td>{recipe.matching_ingredients.join(', ')}</td>
            </tr>
        ))}
        </tbody>

    </table>
  );
};

export default RecipeList;
