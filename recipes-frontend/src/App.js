// src/App.js
import React, { useState } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import SearchPage from './components/SearchPage';
import RecipeDetail from './components/RecipeDetail';

const App = () => {
  const [recipes, setRecipes] = useState([]);
  const [searchQuery, setSearchQuery] = useState('');

  return (
    <Router>
      <Routes>
        <Route path="/" element={<SearchPage recipes={recipes} setRecipes={setRecipes} searchQuery={searchQuery} setSearchQuery={setSearchQuery} />} />
        <Route path="/recipe/:id" element={<RecipeDetail />} />
      </Routes>
    </Router>
  );
};

export default App;
