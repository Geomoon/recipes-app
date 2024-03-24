package database

import (
	"fmt"
	"recipes-api/pkg/recipe"
	"time"

	"gorm.io/gorm"
)

type RecipeRepository struct {
	db *gorm.DB
}

func NewRecipeRepository(db *gorm.DB) recipe.Repository {
	return &RecipeRepository{
		db: db,
	}
}

func (repo *RecipeRepository) GetAll() ([]recipe.Recipe, error) {
	var list []recipe.Recipe

	err := (*repo.db).Joins("Type").Order("recipes.created_at DESC").Find(&list).Error
	if err != nil {
		return []recipe.Recipe{}, err
	}
	return list, nil
}

func (repo *RecipeRepository) GetByID(id string) (recipe.Recipe, error) {
	var entity recipe.Recipe

	err := repo.db.
		Preload("Type").
		Preload("Steps", func(db *gorm.DB) *gorm.DB {
			return db.Order("recipe_steps.rest_order ASC")
		}).
		Preload("Ingredients").
		Where("recipes.reci_uuid = ?", id).
		First(&entity).
		Error

	if err != nil {
		return recipe.Recipe{}, err
	}
	var timeMap int64
	err = repo.db.Raw(` 
		select coalesce( sum(coalesce(rest_time, 0)), 0 )::integer as time 
		from recipe_steps 
		righ join ( select 1 ) on true
		where reci_uuid = ?
		`, id).
		Scan(&timeMap).
		Error
	if err != nil {
		return recipe.Recipe{}, err
	}

	entity.Time = uint(timeMap)
	return entity, nil
}

func (repo *RecipeRepository) Save(recipe recipe.Recipe) (string, error) {
	err := (*repo.db).Save(&recipe).Error

	if err != nil {
		return "", err
	}
	return recipe.ID, nil
}

func (repo *RecipeRepository) Delete(id string) error {
	err := (*repo.db).Where("reci_uuid = ?", id).Delete(&recipe.Recipe{}).Error
	return err
}

func (repo *RecipeRepository) GetAllByType(retyId string) ([]recipe.GetRecipeListDTO, error) {
	var results []map[string]interface{}

	err := (*repo.db).Raw(`
			with recipe_time as (
				select reci_uuid, sum(rest_time) as time 
				from recipe_steps
				group by reci_uuid 
			)
			select res.*, coalesce(rest.time, 0) as time
			from recipes res 
			left join recipe_time rest on rest.reci_uuid = res.reci_uuid 
			where res.rety_uuid = ?
	`, retyId).Scan(&results).Error

	fmt.Println(results)

	if err != nil {
		return []recipe.GetRecipeListDTO{}, nil
	}

	list := make([]recipe.GetRecipeListDTO, len(results))

	for i, v := range results {
		list[i] = recipe.GetRecipeListDTO{
			ID:          v["reci_uuid"].(string),
			Name:        v["reci_name"].(string),
			Img:         v["reci_img"].(string),
			NumPortions: uint(v["reci_num_portions"].(int32)),
			Time:        uint(v["time"].(int64)),
			CreatedAt:   v["created_at"].(time.Time),
		}
	}
	return list, nil
}
