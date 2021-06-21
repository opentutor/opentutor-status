LICENSE=LICENSE
LICENSE_HEADER=LICENSE_HEADER
VENV=.venv
$(VENV):
	$(MAKE) $(VENV)-update

.PHONY: $(VENV)-update
$(VENV)-update:
	[ -d $(VENV) ] || python3.8 -m venv $(VENV)
	$(VENV)/bin/pip install --upgrade pip
	$(VENV)/bin/pip install -r ./requirements.txt

.PHONY: docker-build
docker-build:
	cd opentutor_status && $(MAKE) docker-build

.PHONY: format
format: $(VENV)
	$(VENV)/bin/black .

LICENSE:
	@echo "you must have a LICENSE file" 1>&2
	exit 1

LICENSE_HEADER:
	@echo "you must have a LICENSE_HEADER file" 1>&2
	exit 1

.PHONY: license
license: LICENSE LICENSE_HEADER $(VENV)
	. $(VENV)/bin/activate \
		&& python -m licenseheaders -t LICENSE_HEADER -d opentutor_status/src $(args) \
		&& python -m licenseheaders -t LICENSE_HEADER -d opentutor_status/tests $(args)

.PHONY: test
test:
	cd opentutor_status && $(MAKE) test

.PHONY: test-all
test-all:
	cd opentutor_status && $(MAKE) test-all

.PHONY: test-format
test-format: $(VENV)
	$(VENV)/bin/black --check .

.PHONY: test-lint
test-lint: $(VENV)
	$(VENV)/bin/flake8 .

.PHONY: test-license
test-license: LICENSE LICENSE_HEADER
	args="--check" $(MAKE) license

.PHONY: test-types
test-types: $(VENV)
	. $(VENV)/bin/activate \
		&& mypy opentutor_status  \
		&& mypy word2vec

.PHONY: update-deps
update-deps: $(VENV)
	. $(VENV)/bin/activate && pip-upgrade requirements*
