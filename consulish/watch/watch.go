package watch

import (
	"github.com/richjddavis/consul-vendoring-reproduction/consulish/api"
)

func NewServiceEntry(id string) interface{} {
	return &api.ServiceEntry{ID: id}
}
