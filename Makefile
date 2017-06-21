REPOSITORY_URL ?= https://src-d.github.io/charts/

REPOSITORY_FOLDER :=  $(shell pwd)/repository
CHARTS_FOLDER := $(shell pwd)
CHARTS := $(shell ls -d $(CHARTS_SOURCE_FOLDER)*/ | grep -v repository)

HELM_BIN := helm --debug
HELM_PACKAGE := $(HELM_BIN) package
HELM_INDEX := $(HELM_BIN) repo index

all: repository

dependencies:
	mkdir -p $(REPOSITORY_FOLDER)

repository: index

index: $(CHARTS)
	$(HELM_INDEX) \
		--url $(REPOSITORY_URL) \
		$(REPOSITORY_FOLDER)

$(CHARTS): dependencies
	$(HELM_PACKAGE) \
		--save=false \
		--destination $(REPOSITORY_FOLDER) \
		$(CHARTS_FOLDER)/$(@)

clean:
	rm -rf $(REPOSITORY_FOLDER)

.PHONY: $(CHARTS) index
