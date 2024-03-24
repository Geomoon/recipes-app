package api

import (
	"recipes-api/internal/handlers"
	recipetype "recipes-api/pkg/recipe_type"

	"github.com/gin-gonic/gin"
)

func RecipeTypeRoutes(router *gin.RouterGroup, service *recipetype.Service) {
	var route = "/recipe-types"
	h := handlers.NewRecipeTypeHandler(service)
	r := router.Group(route)

	r.GET("", h.GetAll)
}
