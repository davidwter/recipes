// src/components/RecipeDetail.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useParams, useNavigate } from 'react-router-dom';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';



const RecipeDetail = ({searchQuery}) => {
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

  const isIngredientMatch = (ingredientName) => {
    if (!searchQuery) return false;
    const queryIngredients = searchQuery.split(',').map(ingredient => ingredient.trim().toLowerCase());
    return queryIngredients.includes(ingredientName.toLowerCase());
  };


  if (!recipe) return <div>Loading...</div>;

  return (
    <div>
    <Button onClick={() => navigate(-1)} variant="contained" color="secondary">Back to Search</Button>    
    <Typography variant="h4">{recipe.title}</Typography>
      {recipe.image && <img src={recipe.image} alt={recipe.title} style={{ maxWidth: '100%' }} />}
      <Typography variant="h6">Ingredients</Typography>
      <List>
        {recipe.ingredients.map((ingredient, index) => (
          <ListItem key={index} style={isIngredientMatch(ingredient.name) ? { fontWeight: 'bold' } : {}}>
            {ingredient.name}
          </ListItem>
        ))}
      </List>

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
