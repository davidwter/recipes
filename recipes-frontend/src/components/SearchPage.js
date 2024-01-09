// src/components/SearchPage.js
import React from 'react';
import Search from './Search';
import RecipeList from './RecipeList';

const SearchPage = ({ recipes, setRecipes, searchQuery, setSearchQuery }) => {
  return (
    <div>
      <Search onSearch={setRecipes} searchQuery={searchQuery} setSearchQuery={setSearchQuery} />
      <RecipeList recipes={recipes} />
    </div>
  );
};

export default SearchPage;
