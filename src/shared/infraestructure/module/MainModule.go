package module

import (
	"math/rand"
	"net/http"
	"time"

	"github.com/labstack/echo/v4"
	"github.com/r0x16/Terra-kion/src/shared/domain"
	"github.com/r0x16/Terra-kion/src/shared/domain/model"
	"github.com/r0x16/Terra-kion/src/shared/infraestructure/drivers"
	"github.com/r0x16/Terra-kion/src/shared/infraestructure/repository"
)

type MainModule struct {
	Bundle *drivers.ApplicationBundle
}

var _ domain.ApplicationModule = &MainModule{}

// Setups base main module routes
func (m *MainModule) Setup() {
	// This is a simple GET route that store a random string in a list
	// and shows the last 10 values
	// It also checks if the last value was created less than 5 seconds ago
	// If so, it waits until 5 seconds have passed
	m.Bundle.Server.GET("/", func(c echo.Context) error {
		repo := repository.NewRandomRepositoryGorm(m.Bundle.Database.Connection)
		random := &model.Random{
			Value: GenerateRandomString(10),
		}
		
		lastValues, err := repo.GetLast(9)
		if err != nil {
			return c.JSONPretty(http.StatusInternalServerError, err, "  ")
		}

		// If there are values, check if the last one was created less than 5 seconds ago
		// If so, wait until 5 seconds have passed
		if len(lastValues) > 0 {
			current := time.Now()
			diff := current.Sub(lastValues[0].CreatedAt)
			if diff < 5 * time.Second {
				pauseDuration := 5 * time.Second - diff
				time.Sleep(pauseDuration)
			}
		}

		repo.Store(random) // Store the new value in the database

		// Prepend the new value to the slice
		lastValues = append([]*model.Random{random}, lastValues...)

		return c.JSONPretty(http.StatusOK, lastValues, "  ")
	})
}

// Generates a random string of length n
func GenerateRandomString(n int) string {
    const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    rand.Seed(time.Now().UnixNano())

    b := make([]byte, n)
    for i := range b {
        b[i] = letters[rand.Intn(len(letters))]
    }

    return string(b)
}