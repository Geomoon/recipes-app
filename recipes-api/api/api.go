package api

import (
	"fmt"
	"log"
	"recipes-api/database"
	"recipes-api/pkg/recipe"
	recipeingredient "recipes-api/pkg/recipe_ingredient"
	recipestep "recipes-api/pkg/recipe_step"
	recipetype "recipes-api/pkg/recipe_type"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type Server struct {
	port string
	g    *gin.Engine
	db   *gorm.DB
}

func NewServer(port string, db *gorm.DB) *Server {
	return &Server{
		port: port,
		db:   db,
		g:    gin.Default(),
	}
}

func (s *Server) Run() {
	s.setup()
	err := s.g.Run(fmt.Sprintf(":%s", s.port))
	if err != nil {
		log.Fatal("Error: Run Server: ", err.Error())
	} else {
		log.Println("Server running at port: ", s.port)
	}
}

func (s *Server) setup() {

	recipeTypeRepo := database.NewRecipeTypeRepository(s.db)
	recipeTypeService := recipetype.NewService(&recipeTypeRepo)

	ingredientRepository := database.NewRecipeIngredientRepository(s.db)
	ingredientService := recipeingredient.NewService(&ingredientRepository)

	stepsRepository := database.NewRecipeStepRepository(s.db)
	stepsService := recipestep.NewService(&stepsRepository)

	recipeRepo := database.NewRecipeRepository(s.db)
	recipeService := recipe.NewService(&recipeRepo, recipeTypeService, ingredientService, stepsService)

	v1NoAuth := s.g.Group("/api/v1")

	// ROUTES
	{
		RecipeTypeRoutes(v1NoAuth, recipeTypeService)
		RecipeRoutes(v1NoAuth, recipeService)
	}

}
