
all: test

.PHONY: test

test:
	python setup.py build_ext --inplace
	python test/yamlio_test.py
	python test/pool_server_test.py
	python test/unicode_test.py
	python test/hash_test.py
	python test/test_readable_slaw.py

