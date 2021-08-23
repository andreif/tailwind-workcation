clean:
	rm -rf node_modules
	rm -rf _site
	rm -rf vendor
	rm -rf .jekyll-cache
	rm *.lock package-lock.json
	rm -f assets/css/styles.css


node_modules:
	npm install


vendor/bundle:
	bundle


setup: node_modules vendor/bundle


watch-tailwind: node_modules
	npx tailwindcss -i assets/css/tailwind.css -o assets/css/styles.css --watch


build-tailwind: node_modules
	NODE_ENV=production npx tailwindcss -i assets/css/tailwind.css -o assets/css/styles.css --minify


server: vendor/bundle
	bundle exec jekyll serve


build-jekyll: vendor/bundle
	bundle exec jekyll build


build-jekyll-docker:
	mkdir -p .jekyll-cache
	mkdir -p _site
	chmod 777 .jekyll-cache
	chmod 777 _site
	docker run \
		-v "$(shell pwd)":/srv/jekyll \
		jekyll/builder:latest \
		/bin/bash -c "jekyll build"  # --future


build: build-tailwind build-jekyll
