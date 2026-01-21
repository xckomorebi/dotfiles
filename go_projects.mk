GOSRC_FILES			:= $(shell find . -name '*.go' -not -path './.git/*')
SKIP_ARGS			:= $(shell get_skip_tests.py)
COMMIT_HASH			:= $(shell git rev-parse --short HEAD)
CI_COMMIT_BRANCH	:= $(shell git rev-parse --abbrev-ref HEAD)

USERNAME			?= $(shell whoami)
PROJECT_NAME		?= $(shell basename $(shell pwd))
BIN_NAME			?= $(subst -,_,$(PROJECT_NAME))_bin
BIN_PATH			?= output/$(BIN_NAME)
COVERAGE_ENV_PATH	:= output/coverage_env.sh

HARBOR_ADDR 	?= harbor.infini-ai.com
IMAGE_ADDR 		?= $(HARBOR_ADDR)/$(USERNAME)/$(PROJECT_NAME):$(COMMIT_HASH)
DOCKERFILE_PATH ?= dockerfile

COVERAGE_REQUIREMENT 				?= 0
CI_MERGE_REQUEST_TARGET_BRANCH_NAME ?= main
DEFAULT_TARGET 						?= coverage

export CI_PIPELINE_SOURCE=merge_request_event

.PHONY: all
all: $(DEFAULT_TARGET)

.PHONY: help
help:
	@echo "Go Project Makefile"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  all        Run the default target ($(DEFAULT_TARGET))"
	@echo "  test       Run tests and generate coverage.xml"
	@echo "  coverage   Run tests, check coverage requirement, and open coverage.html"
	@echo "  clean      Remove generated files (coverage.*, output/)"
	@echo "  image      Build Docker image for linux/amd64"
	@echo "  push       Build and push Docker image to Harbor"
	@echo "  mocks      Generate mocks in pkg/mocks"
	@echo "  help       Show this help message"
	@echo ""
	@echo "Variables (override with VAR=value):"
	@echo "  USERNAME              = $(USERNAME)"
	@echo "  PROJECT_NAME          = $(PROJECT_NAME)"
	@echo "  BIN_NAME              = $(BIN_NAME)"
	@echo "  BIN_PATH              = $(BIN_PATH)"
	@echo "  HARBOR_ADDR           = $(HARBOR_ADDR)"
	@echo "  IMAGE_ADDR            = $(IMAGE_ADDR)"
	@echo "  DOCKERFILE_PATH       = $(DOCKERFILE_PATH)"
	@echo "  DEFAULT_TARGET        = $(DEFAULT_TARGET)"

.PHONY: test
test: coverage.xml

.PHONY: just_test
just_test:
	gotestsum -- -gcflags="all=-N -l" $(SKIP_ARGS) ./...

.PHONY: coverage
coverage: coverage.xml
	COVERAGE_REQUIREMENT=$(COVERAGE_REQUIREMENT) CI_MERGE_REQUEST_TARGET_BRANCH_NAME=$(CI_MERGE_REQUEST_TARGET_BRANCH_NAME) ./ci-coverage.sh
	@open coverage.html

.PHONY: clean
clean:
	rm -f coverage.txt coverage.xml tests.xml coverage.html
	rm -rf output/

coverage.txt: $(GOSRC_FILES)
	gotestsum -- -coverprofile=coverage.txt -gcflags="all=-N -l" -covermode=count -coverpkg=./pkg/... $(SKIP_ARGS) ./... || (rm -f coverage.txt && exit 1)
	gocovmerge coverage.txt > coverage_merged.txt
	mv coverage_merged.txt coverage.txt
	sed -i '' 's|gitlab.infini-ai.com/infini-cloud/$(PROJECT_NAME)/|./|g' coverage.txt

coverage.xml: coverage.txt
	gocover-cobertura < coverage.txt > coverage.xml

$(BIN_PATH): $(GOSRC_FILES)
	@mkdir -p output
	GOOS=linux GOARCH=amd64 go build -cover -o $@ -covermode=atomic -coverpkg=./...

$(COVERAGE_ENV_PATH): $(GOSRC_FILES)
	@mkdir -p output
	echo "COMMIT_HASH=${COMMIT_HASH}" > $(COVERAGE_ENV_PATH)
	echo "GIT_BRANCH=${CI_COMMIT_BRANCH}" >> $(COVERAGE_ENV_PATH)

.PHONY: image
image: $(BIN_PATH) $(COVERAGE_ENV_PATH)
	docker rmi --force $(IMAGE_ADDR)
	docker build --platform linux/amd64 -t $(IMAGE_ADDR) -f $(DOCKERFILE_PATH) .

.PHONY: push
push: image
	docker push $(IMAGE_ADDR)
	@echo copy $(IMAGE_ADDR) to clipboard...
	@echo $(IMAGE_ADDR) | pbcopy

.PHONY: mocks
mocks:
	$(MAKE) -C pkg/mocks