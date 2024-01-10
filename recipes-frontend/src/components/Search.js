// src/components/Search.js
import React from 'react';
import { Button, TextField, Grid, Paper, Typography } from '@mui/material';


import axios from 'axios';

  

const Search = ({ onSearch, searchQuery, setSearchQuery }) => {
  const handleSearch = async () => {
    if (!searchQuery.trim()) {
      alert('Please enter some ingredients.');
      return;
    }

    try {
      const response = await axios.get(`http://localhost:3000/recipes/search?ingredients=${searchQuery}`);
      onSearch(response.data);
    } catch (error) {
      console.error('Error fetching recipes', error);
      alert('An error occurred while fetching recipes.');
    }
  };

  const handleClear = () => {
    setSearchQuery('');  // Clear the search query
    onSearch([]);        // Clear the search results
  };

  return (
    <Paper style={{ padding: '2rem', margin: '2rem' }}> 
        <Typography variant="h6" gutterBottom>Quels sont vos ingrédients ?</Typography>
        <Grid container spacing={2} alignItems="center">
            <Grid item xs={12} sm={8}>
                <TextField
                    label="Ingrédients"
                    variant="outlined"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    placeholder="Séparés par une virgule"
                    fullWidth
                    margin="normal"
                />
            </Grid>
            <Grid item xs={12} sm={4}>
                <Button variant="contained" color="primary" onClick={handleSearch} style={{ marginRight: '1rem' }}>
                    Rechercher
                </Button>
                <Button variant="outlined" onClick={handleClear}>
                    Effacer
                </Button>
            </Grid>
        </Grid>
        
    </Paper>


   
  );
};

export default Search;
