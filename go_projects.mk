COVERAGE_REQUIREMENT ?= 0
CI_MERGE_REQUEST_TARGET_BRANCH_NAME ?= main
COMMIT_HASH ?= $(shell git rev-parse --short HEAD)

export CI_PIPELINE_SOURCE=merge_request_event

GOSRC_FILES := $(shell find . -name '*.go' -not -path './.git/*')

PROJECT_NAME := $(shell basename $(shell pwd))
BIN_NAME ?= $(shell echo $(PROJECT_NAME) | tr '-' '_')_bin

.PHONY: all
all: coverage

.PHONY: test
test: coverage.xml

.PHONY: coverage
coverage: coverage.xml
	COVERAGE_REQUIREMENT=$(COVERAGE_REQUIREMENT) CI_MERGE_REQUEST_TARGET_BRANCH_NAME=$(CI_MERGE_REQUEST_TARGET_BRANCH_NAME) ./ci-coverage.sh
	open coverage.html

.PHONY: clean
clean:
	rm -f coverage.txt coverage.xml tests.xml coverage.html $(BIN_NAME)

coverage.txt: $(GOSRC_FILES)
	gotestsum -- -coverprofile=coverage.txt -gcflags="all=-N -l" -covermode=count -coverpkg=./pkg/... -skip '' ./... || (rm -f coverage.txt && exit 1)
	gocovmerge coverage.txt > coverage_merged.txt
	mv coverage_merged.txt coverage.txt
	sed -i '' 's|gitlab.infini-ai.com/infini-cloud/$(PROJECT_NAME)/|./|g' coverage.txt

coverage.xml: coverage.txt
	gocover-cobertura < coverage.txt > coverage.xml 

$(BIN_NAME): $(GOSRC_FILES)
	GOOS=linux GOARCH=amd64 go build -o $@ .

.PHONY: image
image: $(BIN_NAME)
	docker rmi --force harbor.infini-ai.com/xuchen/$(PROJECT_NAME):$(COMMIT_HASH)
	docker build --platform linux/amd64 -t harbor.infini-ai.com/xuchen/$(PROJECT_NAME):$(COMMIT_HASH) -f dockerfile.xc .

.PHONY: mocks
mocks:
	$(MAKE) -C pkg/mocks
