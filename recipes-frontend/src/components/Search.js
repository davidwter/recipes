// src/components/Search.js
import React from 'react';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';

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
    <div>
      <TextField
        label="Enter ingredients"
        variant="outlined"
        value={searchQuery}
        onChange={(e) => setSearchQuery(e.target.value)}
        placeholder="Separated by commas"
        fullWidth
        margin="normal"
      />
      <Button variant="contained" color="primary" onClick={handleSearch}>
        Search
      </Button>
      <Button variant="outlined" onClick={handleClear}>
        Clear
      </Button>
    </div>
  );
};

export default Search;
