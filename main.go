package main

import (
	"fmt"

	"github.com/google/uuid"
	"github.com/richjddavis/consul-vendoring-reproduction/consulish/api"
	"github.com/richjddavis/consul-vendoring-reproduction/consulish/watch"
)

func main() {
	entry := watch.NewServiceEntry(uuid.New().String())
	switch entry.(type) {
	case *api.ServiceEntry:
		fmt.Printf("entry is the *api.ServiceEntry we expect (%T): %#v\n", entry, entry)
	default:
		fmt.Printf("entry is _not_ the *api.ServiceEntry we expect (%T): %#v\n", entry, entry)
	}
}
