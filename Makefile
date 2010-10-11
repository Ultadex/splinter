all: test

clean:
	@find . -name "*.pyc" -delete
	
dependencies: specloud coverage selenium flask shoulddsl lxml mechanize

specloud:
	@python -c 'import specloud' 2>/dev/null || pip install --no-deps specloud -r http://github.com/hugobr/specloud/raw/master/requirements.txt

coverage:
	@python -c 'import coverage' 2>/dev/null || pip install coverage

selenium:
	@python -c 'import selenium' 2>/dev/null || pip install selenium

flask:
	@python -c 'import flask' 2>/dev/null || pip install flask

shoulddsl:
	@python -c 'import should_dsl' 2>/dev/null || pip install should-dsl

lxml:
	@python -c 'import lxml' 2>/dev/null || pip install lxml

mechanize:
	@python -c 'import mechanize' 2>/dev/null || pip install mechanize


test: dependencies clean
	@echo "Running all tests..."
	python tests/fake_webapp.py &
	specloud --nocapture --with-coverage --cover-erase --cover-inclusive --cover-package=splinter tests
	kill -9 `ps aux | grep 'python tests/fake_webapp.py' | grep -v grep | awk '{print $$2}'`

