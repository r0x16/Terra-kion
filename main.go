package main

import "github.com/r0x16/Terra-kion/src/shared/infraestructure"

func main() {
	application := &infraestructure.Main{}
	application.RunServices()
}
