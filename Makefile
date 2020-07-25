test: lint

node_modules: yarn.lock
	@yarn -s --pure-lockfile
	@touch node_modules

lint: node_modules
	yarn -s run stylelint --color *.css

update: node_modules
	yarn -s run updates -cu
	yarn -s run rimraf node_modules
	yarn -s
	@touch yarn.lock

patch: node_modules lint build
	yarn -s run versions -pdC patch github-code-wrap.user.css
	git push --tags origin master

minor: node_modules lint build
	yarn -s run versions -pdC minor github-code-wrap.user.css
	git push --tags origin master

major: node_modules lint build
	yarn -s run versions -pdC major github-code-wrap.user.css
	git push --tags origin master

.PHONY: test lint update patch minor major
