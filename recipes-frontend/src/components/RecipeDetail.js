// src/components/RecipeDetail.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useParams, useNavigate } from 'react-router-dom';

const RecipeDetail = () => {
  const [recipe, setRecipe] = useState(null);
  const { id } = useParams();
  const navigate = useNavigate();

  useEffect(() => {
    const fetchRecipe = async () => {
      try {
        const response = await axios.get(`http://localhost:3000/recipes/${id}`);
        console.log(response.data);
        setRecipe(response.data);
      } catch (error) {
        console.error('Error fetching recipe details', error);
      }
    };

    fetchRecipe();
  }, [id]);

  if (!recipe) return <div>Loading...</div>;

  return (
    <div>
    <button onClick={() => navigate(-1)}>Back to Search</button>    
      <h1>{recipe.title}</h1>
      {recipe.image && <img src={recipe.image} alt={recipe.title} />}
      <h3>Ingrédients</h3>
      {recipe.ingredients && (
        <ul>
          {recipe.ingredients.map((ingredient, index) => (
            <li key={index}>
              {ingredient.name} {}
            </li>
          ))}
        </ul>
      )}

      <p>Temps de préparation : {recipe.prep_time}</p>
      <p>Temps de cuisson : {recipe.cook_time}</p>
      <p>Temps total : {recipe.total_time}</p>
      <p>Difficulté : {recipe.difficulty}</p>
      <p>Note : {recipe.rate}</p>
      <p>Nombre de commentaires : {recipe.nb_comments}</p>
      <p>Autheur : {recipe.author}</p>
    </div>
  );
};

export default RecipeDetail;
