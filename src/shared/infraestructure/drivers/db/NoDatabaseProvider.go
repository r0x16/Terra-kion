package db

import "github.com/r0x16/Terra-kion/src/shared/domain"

/*
 * Represents a fake Database connection
 */
type NoDatabaseProvider struct {
}

var _ domain.DatabaseProvider = &NoDatabaseProvider{}

// Connect implements domain.DatabaseProvider.
func (*NoDatabaseProvider) Connect() error {
	return nil
}