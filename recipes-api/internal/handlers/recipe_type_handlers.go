package handlers

import (
	"net/http"
	recipetype "recipes-api/pkg/recipe_type"

	"github.com/gin-gonic/gin"
)

type RecipeTypeHandler struct {
	service *recipetype.Service
}

func NewRecipeTypeHandler(service *recipetype.Service) *RecipeTypeHandler {
	return &RecipeTypeHandler{
		service: service,
	}
}

func (h *RecipeTypeHandler) GetAll(ctx *gin.Context) {
	list, err := h.service.GetAll()

	if err != nil {
		ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}

	ctx.JSON(http.StatusOK, list)
}
