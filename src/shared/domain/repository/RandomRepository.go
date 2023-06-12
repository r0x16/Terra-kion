package repository

import "github.com/r0x16/Terra-kion/src/shared/domain/model"

type RandomRepository interface {
	Store(*model.Random) error
	GetLast(int) ([]*model.Random, error)
}