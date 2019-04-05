#! /usr/bin/env bash

package="github.com/richjddavis/consul-vendoring-reproduction"
src="$GOPATH/src/$package"
consulishSrc="$src/consulish"
vendorDir="${consulishSrc}/vendor"
vendorPackage="$vendorDir/$package/consulish"

function vendor() {
    mkdir -p "$vendorPackage"
    rsync -r "$src/consulish" "$(dirname "$vendorPackage")"
}

function devendor() {
    rm -r "$vendorDir"
}

devendor

rm ./consul-vendoring-reproduction
go clean -cache
echo "Without self-vendoring"
go build -o ./consul-vendoring-reproduction -- github.com/richjddavis/consul-vendoring-reproduction
./consul-vendoring-reproduction

vendor

rm ./consul-vendoring-reproduction
go clean -cache
echo "With self-vendoring"
go build -o ./consul-vendoring-reproduction -- github.com/richjddavis/consul-vendoring-reproduction
./consul-vendoring-reproduction
