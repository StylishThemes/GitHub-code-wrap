node_modules: package-lock.json
	npm install --no-save
	@touch node_modules

.PHONY: test
test: lint

.PHONY: lint
lint: node_modules
	npx stylelint --color *.css

.PHONY: update
update: node_modules
	npx updates -cu
	rm -rf node_modules package-lock.json
	npm install
	@touch node_modules

.PHONY: patch
patch: node_modules test
	npx versions patch github-code-wrap.user.css

.PHONY: minor
minor: node_modules test
	npx versions minor github-code-wrap.user.css

.PHONY: major
major: node_modules test
	npx versions major github-code-wrap.user.css
