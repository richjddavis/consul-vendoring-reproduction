This package reproduces (in spirit) a vendoring-related issue we're experiencing in https://github.com/hashicorp/consul's `master` branch ([commit fc7a1e0](https://github.com/hashicorp/consul/commit/fc7a1e017525c14508e366593d9ace7b350104f7)).

Be sure to run this _in_ $GOPATH, as it's specifically an issue that's experienced when not using Go modules.

Running the following example:

```sh
go get -u github.com/richjddavis/consul-vendoring-reproduction;
cd $GOPATH/src/github.com/richjddavis/consul-vendoring-reproduction;
./demo.sh
```

Provides the output:

```
Without self-vendoring
entry is the *api.ServiceEntry we expect (*api.ServiceEntry): &api.ServiceEntry{ID:"7e462075-36f7-45fb-b9c3-665c41291950"}
With self-vendoring
entry is _not_ the *api.ServiceEntry we expect (*api.ServiceEntry): &api.ServiceEntry{ID:"c690b8ef-ab9d-441f-a230-d54e82713162"}
```

This is because in the _With self-vendoring_ example, `github.com/richjddavis/consul-vendoring-reproduction/consulish` vendors itself at `github.com/richjddavis/consul-vendoring-reproduction/consulish/vendor/github.com/richjddavis/consul-vendoring-reproduction/consulish`. Specifically, the `github.com/richjddavis/consul-vendoring-reproduction/consulish/watch` package imports the vendored version of `github.com/richjddavis/consul-vendoring-reproduction/consulish/api`, returning an vendored type that's incompatible with `github.com/richjddavis/consul-vendoring-reproduction/consulish/api` as used by `main.go`. Without self-vendoring, the types are the same.
