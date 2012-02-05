from settings import *

ROOT_URLCONF = 'settings.test.urls'

DATABASE_ENGINE = 'sqlite3'
DATABASE_NAME = ':memory:'

INSTALLED_APPS += ('django_nose', )
TEST_RUNNER = 'django_nose.run_tests'
