// src/components/RecipeList.js
import React from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

import { Link } from 'react-router-dom';

const RecipeList = ({ recipes }) => {
  return (
    <TableContainer component={Paper}>
        <Table>
            <TableHead>
                <TableRow>
                    <TableCell>
                        Recette
                    </TableCell>
                    <TableCell>
                        Nombre d'ingrédients correspondant
                    </TableCell>
                    <TableCell>
                        Ingrédients correspondant
                    </TableCell>
                </TableRow>
            </TableHead>
            <TableBody>
                {recipes.map((recipe) => (
                    <TableRow key={recipe.id}>
                        <TableCell><Link to={`/recipe/${recipe.id}`}>{recipe.name}</Link></TableCell>
                        <TableCell>{recipe.matching_ingredients_count}</TableCell>
                        <TableCell>{recipe.matching_ingredients.join(', ')}</TableCell>
                    </TableRow>
                ))}
                </TableBody>
        </Table>
    </TableContainer>
  );
};

export default RecipeList;
