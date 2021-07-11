# Current version
# VERSION ?= 1.0.0

.DEFAULT_GOAL:=help

PATH  := $(PATH):$(PWD)/bin
SHELL := env PATH=$(PATH) /bin/bash
OS    = $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH  = $(shell uname -m | sed 's/x86_64/amd64/')
OSOPER   = $(shell uname -s | tr '[:upper:]' '[:lower:]' | sed 's/darwin/apple-darwin/' | sed 's/linux/linux-gnu/')
ARCHOPER = $(shell uname -m )

.PHONY: help clean build install uninstall

help:  ## Display this help
		@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

all: build

clean: ## Cleanup the project folders
		$(info Make: Cleaning up things)
		rm -rf .terraform
		rm terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl

build: ## Install AWS Infrastructure
		$(info Make: nstall AWS Infrastructure)
		terraform init
		terraform apply -auto-approve

destroy: ## Destroy AWS Infrastructure
		$(info Make: Destroy AWS Infrastructure.)
		terraform destroy -auto-approve
