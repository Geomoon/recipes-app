package handlers

import (
	"net/http"
	"recipes-api/pkg/recipe"

	"github.com/gin-gonic/gin"
)

type RecipeHandler struct {
	service *recipe.Service
}

func NewRecipeHandler(service *recipe.Service) *RecipeHandler {
	return &RecipeHandler{
		service: service,
	}
}

func (h *RecipeHandler) GetAll(ctx *gin.Context) {
	recipes, err := h.service.GetAll()
	if err != nil {
		ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}
	ctx.JSON(http.StatusOK, recipes)
}

func (h *RecipeHandler) GetByID(ctx *gin.Context) {
	id := ctx.Param("id")

	recipe, err := h.service.GetByID(id)
	if err != nil {
		ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}
	ctx.JSON(http.StatusOK, recipe)
}

func (h *RecipeHandler) Delete(ctx *gin.Context) {
	id := ctx.Param("id")
	err := h.service.Delete(id)
	if err != nil {
		ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}
	ctx.Status(http.StatusNoContent)
}

func (h *RecipeHandler) Save(ctx *gin.Context) {
	var data recipe.CreateRecipeDTO

	err := ctx.BindJSON(&data)
	if err != nil {
		ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}

	response, err := h.service.Save(data)
	if err != nil {
		ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}

	ctx.JSON(http.StatusCreated, response)
}

func (h *RecipeHandler) Update(ctx *gin.Context) {
	id := ctx.Param("id")
	var data recipe.CreateRecipeDTO
	err := ctx.BindJSON(&data)
	if err != nil {
		ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}

	response, err := h.service.Update(id, data)
	if err != nil {
		ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}

	ctx.JSON(http.StatusCreated, response)
}

func (h *RecipeHandler) GetAllByType(ctx *gin.Context) {
	retyId := ctx.Param("retyId")

	data, err := (*h.service).GetAllByType(retyId)
	if err != nil {
		ctx.AbortWithStatusJSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}

	ctx.JSON(http.StatusOK, data)
}
