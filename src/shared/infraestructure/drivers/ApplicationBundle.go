package drivers

import (
	"github.com/labstack/echo/v4"
	"github.com/r0x16/Terra-kion/src/shared/infraestructure/drivers/db"
)

type ApplicationBundle struct {
	Server   *echo.Echo
	Database *db.NoDatabaseProvider
}

type ActionCallback func(echo.Context, *ApplicationBundle) error

func (bundle *ApplicationBundle) ActionInjection(callback ActionCallback) echo.HandlerFunc {
	return func(c echo.Context) error {
		return callback(c, bundle)
	}
}
