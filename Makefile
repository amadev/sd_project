SELF_DIR=$(shell pwd)
VE_NAME=virtualenv
VE_DIR=$(SELF_DIR)/$(VE_NAME)
BUILD_DIR=$(SELF_DIR)/build

all: install_ve test

install_ve:
    rm -rf $(VE_DIR)
    virtualenv -q $(VE_NAME) --no-site-packages
    $(VE_DIR)/bin/pip install -q -E $(VE_DIR) -r $(SELF_DIR)/requirements.pip
    $(VE_DIR)/bin/python setup.py --quiet develop

test:
    rm -f build/xcoverage.xml
    rm -f build/xunit.xml
    $(VE_DIR)/bin/python manage.py test --settings=settings_test \
    --with-xcoverage --xcoverage-file=$(SELF_DIR)/build/xcoverage.xml \
    --with-xunit  --xunit-file=$(SELF_DIR)/build/xunit.xml --all-modules

inspect:
    rm -f build/pylint.txt
    rm -f build/pep8.txt
    pep8 --repeat $(SELF_DIR) | perl -ple 's/: ([WE]\d+)/: [$1]/' > build/pep8.txt
    pylint -f parseable $(SELF_DIR) > build/pylint.txt
