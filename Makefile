
BuildTime=`date '+%FT%T%z'`
GitBranch=`git symbolic-ref --short -q HEAD`
GitCommit=`git rev-parse --verify HEAD`

LdFlag="-X 'main.BuildTime=${BuildTime}' -X 'main.GitBranch=${GitBranch}' -X 'main.GitCommit=${GitCommit}'"

all: build

build:
	go mod tidy
	go mod vendor
	go build -o webshell_server cmd/webshell/webshell_main.go

build_amd64:
	go mod tidy
	go mod vendor
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags ${LdFlag} -o webshell_server cmd/webshell/webshell_main.go