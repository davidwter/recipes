// src/components/Search.js
import React, {useState} from 'react';
import { Button, TextField, Grid, Paper, Typography,Snackbar, Alert, CircularProgress } from '@mui/material';




import axios from 'axios';

const apiBaseUrl = process.env.REACT_APP_API_BASE_URL || 'http://localhost:3000';



const Search = ({ onSearch, searchQuery, setSearchQuery }) => {
  const [isSearching, setIsSearching] = useState(false);


  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');
  const [snackbarSeverity, setSnackbarSeverity] = useState('info');


  const handleSnackbarClose = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }
    setOpenSnackbar(false);
  };

  const showAlert = (message, severity = 'info') => {
    setSnackbarMessage(message);
    setSnackbarSeverity(severity);
    setOpenSnackbar(true);
  };

  
  const handleSearch = async () => {
    if (!searchQuery.trim()) {
      showAlert('Merci de saisir quelques ingrédients', 'warning');
      return;
    }

    setIsSearching(true); // Start the loading indicator

    try {
      const response = await axios.get(`${apiBaseUrl}/recipes/search?ingredients=${searchQuery}`);
      onSearch(response.data);
      setIsSearching(false); // Stop the loading indicator once data is fetched
    } catch (error) {
      console.error('Error fetching recipes', error);
      showAlert('Une erreur est survenue pendant la récupération des recettes', 'error');
      setIsSearching(false); // Stop the loading indicator in case of an error
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
        {isSearching && (
      <div style={{ display: 'flex', justifyContent: 'center', marginTop: '20px' }}>
        <CircularProgress />
      </div>
    )}
        <Snackbar open={openSnackbar} autoHideDuration={6000} onClose={handleSnackbarClose}>
        <Alert onClose={handleSnackbarClose} severity={snackbarSeverity} sx={{ width: '100%' }}>
          {snackbarMessage}
        </Alert>
      </Snackbar>

    </Paper>


   
  );
};

export default Search;
