package src

import (
	"github.com/r0x16/Terra-kion/src/shared/domain"
	"github.com/r0x16/Terra-kion/src/shared/infraestructure/drivers"
	"github.com/r0x16/Terra-kion/src/shared/infraestructure/module"
)

func ProvideModules(bundle *drivers.ApplicationBundle) []domain.ApplicationModule {
	return []domain.ApplicationModule{
		&module.MainModule{Bundle: bundle},
	}
}
