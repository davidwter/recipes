import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useParams, useNavigate } from 'react-router-dom';
import {
  Button,
  Typography,
  List,
  ListItem,
  Container,
  Grid,
  Card,
  CardContent,
  Box,
  Chip,
} from '@mui/material';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';

const apiBaseUrl = process.env.REACT_APP_API_BASE_URL || 'http://localhost:3000';

const RecipeDetail = ({ searchQuery }) => {
  const [recipe, setRecipe] = useState(null);
  const { id } = useParams();
  const navigate = useNavigate();

  useEffect(() => {
    const fetchRecipe = async () => {
      try {
        const response = await axios.get(`${apiBaseUrl}/recipes/${id}`);
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
    return queryIngredients.some(queryIngredient => ingredientName.toLowerCase().includes(queryIngredient));
  };

  if (!recipe) return <div>Loading...</div>;

  return (
    <Container maxWidth="md">
      <Box my={4}>
        <Button
          startIcon={<ArrowBackIcon />}
          onClick={() => navigate(-1)}
          variant="outlined"
          color="primary"
        >
          Retour à la recherche
        </Button>
      </Box>
      <Grid container spacing={2}>
        <Grid item xs={12}>
          <Typography variant="h3" component="h1" gutterBottom>
            {recipe.title}
          </Typography>
        </Grid>
        <Grid item md={6} xs={12}>
          {recipe.image && (
            <img src={recipe.image} alt={recipe.title} style={{ width: '100%', height: 'auto', borderRadius: '4px' }} />
          )}
        </Grid>
        <Grid item md={6} xs={12}>
          <Typography variant="h6" gutterBottom>Ingrédients</Typography>
          <List>
            {recipe.ingredients.map((ingredient, index) => (
              <ListItem key={index}>
                <Chip
                  label={ingredient.name}
                  color={isIngredientMatch(ingredient.name) ? "primary" : "default"}
                  variant="outlined"
                  style={{ marginRight: '4px' }}
                />
              </ListItem>
            ))}
          </List>
        </Grid>
        <Grid item xs={12}>
          <Card variant="outlined">
            <CardContent>
              <Typography variant="body1">Temps de préparation : {recipe.prep_time}</Typography>
              <Typography variant="body1">Temps de cuisson : {recipe.cook_time}</Typography>
              <Typography variant="body1">Temps total : {recipe.total_time}</Typography>
              <Typography variant="body1">Difficulté : {recipe.difficulty}</Typography>
              <Typography variant="body1">Note : {recipe.rate}</Typography>
              <Typography variant="body1">Nombre de commentaires : {recipe.nb_comments}</Typography>
              <Typography variant="body1">Auteur : {recipe.author}</Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>
    </Container>
  );
};

export default RecipeDetail;
