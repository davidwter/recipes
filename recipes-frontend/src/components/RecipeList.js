// src/components/RecipeList.js
import React from "react";
import {
  Paper,
  TableContainer,
  Table,
  TableHead,
  TableRow,
  TableCell,
  TableBody,
} from "@mui/material";

import { Link } from "react-router-dom";

const RecipeList = ({ recipes }) => {
  return (
    <TableContainer component={Paper} elevation={3}>
      <Table aria-label="simple table">
        <TableHead>
          <TableRow>
            <TableCell>Recette</TableCell>
            <TableCell>Nombre d'ingrédients correspondant</TableCell>
            <TableCell>Ingrédients correspondant</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {recipes.map((recipe) => (
            <TableRow key={recipe.id} hover>
              <TableCell component="th" scope="row">
                <Link to={`/recipe/${recipe.id}`}>{recipe.name}</Link>
              </TableCell>
              <TableCell>{recipe.matching_ingredients_count}</TableCell>
              <TableCell>{recipe.matching_ingredients.join(", ")}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default RecipeList;
