// src/components/SearchPage.js
import React from 'react';
import { useLocation } from 'react-router-dom';

import Search from './Search';
import RecipeList from './RecipeList';

const SearchPage = ({ recipes, setRecipes, searchQuery, setSearchQuery }) => {
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const currentPage = parseInt(queryParams.get('page') || 1, 10);

  return (
    <div>
      <Search 
      onSearch={setRecipes} 
      searchQuery={searchQuery} 
      setSearchQuery={setSearchQuery} 
      currentPage= {currentPage}
      />
      <RecipeList recipes={recipes} />
    </div>
  );
};

export default SearchPage;
