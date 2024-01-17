// src/components/Search.js
import React, { useState } from "react";
import {
  Button,
  TextField,
  Grid,
  Paper,
  Typography,
  Snackbar,
  Alert,
  CircularProgress,
  Pagination,
} from "@mui/material";
import { useNavigate, useLocation } from 'react-router-dom';


import axios from "axios";

const apiBaseUrl =
  process.env.REACT_APP_API_BASE_URL || "http://localhost:3000";

const Search = ({ onSearch, searchQuery, setSearchQuery }) => {
  const [isSearching, setIsSearching] = useState(false);
  //const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(0);

  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState("");
  const [snackbarSeverity, setSnackbarSeverity] = useState("info");

  const navigate = useNavigate();
  const location = useLocation(); 
  const queryParams = new URLSearchParams(location.search);
  const currentPage = parseInt(queryParams.get('page') || 1, 10);

  const handleSnackbarClose = (event, reason) => {
    if (reason === "clickaway") {
      return;
    }
    setOpenSnackbar(false);
  };

  const showAlert = (message, severity = "info") => {
    setSnackbarMessage(message);
    setSnackbarSeverity(severity);
    setOpenSnackbar(true);
  };

  const handleSearch = async (page = 1, isNewSearch = false) => {
    if (!searchQuery.trim()) {
      showAlert("Merci de saisir quelques ingrédients", "warning");
      return;
    }

    

    setIsSearching(true); // Start the loading indicator

    try {
      const response = await axios.get(`${apiBaseUrl}/recipes/search`, {
        params: { ingredients: searchQuery, page: page },
      });
      onSearch(response.data.recipes);
      setTotalPages(response.data.total_pages);
      //setCurrentPage(response.data.current_page);
      setIsSearching(false); // Stop the loading indicator once data is fetched
      if (isNewSearch) {
        navigate(`?page=1`);
    }


    } catch (error) {
      console.error("Error fetching recipes", error);
      showAlert(
        "Une erreur est survenue pendant la récupération des recettes",
        "error"
      );
      setIsSearching(false); // Stop the loading indicator in case of an error
    }
  };

  const handleClear = () => {
    setSearchQuery(""); // Clear the search query
    onSearch([]); // Clear the search results
    navigate(`?page=1`); // Reset the page in the URL

  };

  const handlePageChange = (event, page) => {
      navigate(`?page=${page}`);
      handleSearch(page);
    }

  return (
    <Paper sx={{ padding: "2rem", margin: "2rem" }}>
      <Typography variant="h6" gutterBottom>
        Quels sont vos ingrédients ?
      </Typography>
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
          <Button
            variant="contained"
            color="primary"
            onClick={() => handleSearch(1, true)}
            sx={{ marginRight: "1rem" }}
          >
            Rechercher
          </Button>
          <Button variant="outlined" onClick={handleClear}>
            Effacer
          </Button>
        </Grid>
      </Grid>
      {isSearching && (
        <div
          sx={{
            display: "flex",
            justifyContent: "center",
            marginTop: "20px",
          }}
        >
          <CircularProgress />
        </div>
      )}
      <Snackbar
        open={openSnackbar}
        autoHideDuration={6000}
        onClose={handleSnackbarClose}
      >
        <Alert
          onClose={handleSnackbarClose}
          severity={snackbarSeverity}
          sx={{ width: "100%" }}
        >
          {snackbarMessage}
        </Alert>
      </Snackbar>
      {totalPages > 1 && (
        <Pagination
          count={totalPages}
          page={currentPage}
          onChange={handlePageChange}
          color="primary"
          sx={{
            marginTop: "20px",
            justifyContent: "flex-end",
            display: 'flex'
          }}
        />
      )}
    </Paper>
  );
};

export default Search;
