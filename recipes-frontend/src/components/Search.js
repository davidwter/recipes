// src/components/Search.js
import React from 'react';
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
      <input
        type="text"
        value={searchQuery}
        onChange={(e) => setSearchQuery(e.target.value)}
        placeholder="Enter ingredients, separated by commas"
      />
      <button onClick={handleSearch}>Search</button>
      <button onClick={handleClear}>Clear</button>
    </div>
  );
};

export default Search;
