# Recipes Project

## Project Overview

This project is a web application designed to help users find and view recipes. It consists of two main components: a backend API built with Ruby on Rails, connected to a PostgreSQL database, and a frontend built with React. The application allows users to enter ingredients they have to find matching recipes, browse a list of recipes, and view detailed recipes including the ingredients needed.

## User Stories

1. **Find Recipes by Ingredients**: As a user, I want to enter ingredients I have so that I can find recipes using those ingredients.
2. **Browse Recipes**: As a user, I want to see a list of recipes so that I can choose one to prepare.
3. **View Detailed Recipes**: As a user, I want to view detailed recipes including steps and ingredients needed.

## Data Model

The data model for the Recipes Project is based on three primary entities: `recipes`, `ingredients`, and `recipe_ingredients`. Below is a representation of the database schema:

+----------------+           +---------------------+           +-------------+
|  ingredients   |           |  recipe_ingredients |           |   recipes   |
+----------------+           +---------------------+           +-------------+
| id             |<--------->| ingredient_id       |           | id          |
| name           |           | recipe_id           |<--------->| title       |
| created_at     |           | quantity            |           | instructions|
| updated_at     |           | created_at          |           | prep_time   |
+----------------+           | updated_at          |           | cook_time   |
                             +---------------------+           | total_time  |
                                                               | difficulty  |
                                                               | rate        |
                                                               | people_qty  |
                                                               | image       |
                                                               | author      |
                                                               | nb_comments |
                                                               | created_at  |
                                                               | updated_at  |
                                                               +-------------+

## Where to test the application

The application is deployed on AWS EC2 and is accessible at [http://ec2-3-120-248-186.eu-central-1.compute.amazonaws.com:3001/](http://ec2-3-120-248-186.eu-central-1.compute.amazonaws.com:3001/).

## Installation and Setup

### Prerequisites

- Docker and Docker Compose should be installed on your system.
- Clone the repository to your local machine.

### Setting Up

1. **Edit Configuration**:
   - Open `docker-compose.yml` file.
   - Edit the `REACT_APP_API_BASE_URL` variable to match your backend URL.

2. **Build and Run**:
   - In the project directory, run the following command:

     ```
     docker-compose up --build
     ```

3. **Initialize Database**:
   - Once the containers are up and running, enter the backend container using:

     ```
     docker-compose exec backend bash
     ```

   - To import recipes into the database, run:

     ```
     rails db:import_recipes
     ```

   - Wait for a few minutes for the process to complete.

## Usage

- The application is accessible on port 3001 and is already deployed at [http://ec2-3-120-248-186.eu-central-1.compute.amazonaws.com:3001/](http://ec2-3-120-248-186.eu-central-1.compute.amazonaws.com:3001/).
- The API runs on port 3000.

## Testing

- To run tests for the backend, enter the backend container (`docker-compose exec backend bash`) and execute:

    ```
    rails test
    ```

## Contributing

Currently, there are no specific guidelines for contributing. Feel free to suggest improvements or submit pull requests.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
