export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)

go get github.com/aristanetworks/goarista/cmd/gnmi

