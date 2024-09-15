# Makefile for deploying Flutter web app to GitHub Pages

# Update These Variables
BASE_HREF = '/pixabay_dummy/'  # /pixabay_dummy/ represents the name of the repository
GITHUB_REPO = git@github.com:Mohitkoley/pixabay_dummy.git
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

deploy-web:
    @echo "Clean existing repository..." # print the log
    flutter clean  # flutter command

    @echo "Getting packages..."  # print the log
    flutter pub get # flutter command

    @echo "Building for web..."  # print the log
    flutter build web --base-href $(BASE_HREF) --release   # this command uses the BASE_HREF in your index.html and base_href value is getting from the above variable

    @echo "Deploying to git repository"
    cd build/web && \
    git init && \
    git add . && \
    git commit -m "Deploy Version $(BUILD_VERSION)" && \
    git branch -M main && \
    git remote add origin $(GITHUB_REPO) && \
    git push -f origin main

    @echo "Deployed Successfully!"  # print the log
.PHONY: deploy-web