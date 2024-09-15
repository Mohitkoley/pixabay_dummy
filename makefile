# Makefile for deploying the Flutter web projects to GitHub

BASE_HREF = /$(NAME)/
# Replace with your GitHub username
GITHUB_USER = Mohitkoley
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(NAME)
BUILD_VERSION := $(if $(NAME),$(shell grep 'version:' $(NAME)/pubspec.yaml | awk '{print $$2}'))

include .env

# Deploy the Flutter web project to GitHub
deploy:
ifndef NAME
	$(error NAME is not set. Usage: make deploy NAME=<name>)
endif

	@echo "Clean existing repository"
	flutter clean

	@echo "Getting packages..."
	flutter pub get

	@echo "Generating the web folder..."
	flutter create . --platform web

	@echo "Building for web..."
	flutter build web --base-href $(BASE_HREF) --release --dart-define=KEY=${KEY}

	@echo "Deploying to git repository"
	cd /build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🚀 Flutter web URL: https://$(GITHUB_USER).github.io/$(NAME)/"

.PHONY: deploy