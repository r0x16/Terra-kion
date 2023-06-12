package repository

import (
	"github.com/r0x16/Terra-kion/src/shared/domain/model"
	i "github.com/r0x16/Terra-kion/src/shared/domain/repository"
	"gorm.io/gorm"
)

type RandomRepositoryGorm struct {
	db *gorm.DB
}

var _ i.RandomRepository = &RandomRepositoryGorm{}

func NewRandomRepositoryGorm(db *gorm.DB) *RandomRepositoryGorm {
	repo := &RandomRepositoryGorm{db: db}
	repo.db.AutoMigrate(&model.Random{})
	return repo
}

// GetAll returns all random values from the database.
func (r *RandomRepositoryGorm) GetLast(count int) ([]*model.Random, error) {
	var randoms []*model.Random
	result := r.db.Order("created_at desc").Limit(count).Find(&randoms)
	return randoms, result.Error
}

// Store a random value in the database.
func (r *RandomRepositoryGorm) Store(random *model.Random) error {
	result := r.db.Create(random)
	return result.Error
}