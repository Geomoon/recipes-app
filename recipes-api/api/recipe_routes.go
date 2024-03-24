package api

import (
	"recipes-api/internal/handlers"
	"recipes-api/pkg/recipe"

	"github.com/gin-gonic/gin"
)

func RecipeRoutes(router *gin.RouterGroup, service *recipe.Service) {
	var route = "/recipes"

	h := handlers.NewRecipeHandler(service)
	r := router.Group(route)

	r.GET("", h.GetAll)
	r.GET(":id", h.GetByID)
	r.GET("type/:retyId", h.GetAllByType)
	r.POST("", h.Save)
	r.PATCH(":id", h.Update)
	r.DELETE(":id", h.Delete)
}
