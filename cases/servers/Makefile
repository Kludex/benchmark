network = data
.DEFAULT_GOAL := run

all: api html upload

upload:
	docker run --network $(network) \
	-e APP=$(app) -e SERVER=$(server) -e FILENAME=/results/upload.csv -e WORKERS=$(workers) \
	-v $(shell pwd)/results:/results -v $(shell pwd)/wrk:/scripts \
	williamyeh/wrk http://$(server)-$(app):8080/upload -d15s -t4 -c64 -s /scripts/upload.lua

html:
	docker run --network $(network) \
	-e APP=$(app) -e SERVER=$(server) -e FILENAME=/results/html.csv -e WORKERS=$(workers) \
	-v $(shell pwd)/results:/results -v $(shell pwd)/wrk:/scripts \
	williamyeh/wrk http://$(server)-$(app):8080/html -d15s -t4 -c64 -s /scripts/html.lua

api:
	docker run --network $(network) \
	-e APP=$(app) -e SERVER=$(server) -e FILENAME=/results/api.csv -e WORKERS=$(workers) \
	-v $(shell pwd)/results:/results -v $(shell pwd)/wrk:/scripts \
	williamyeh/wrk http://$(server)-$(app):8080/api/users/1/records/1?query=test -d15s -t4 -c64 -s /scripts/api.lua

run:
	$(foreach server, uvicorn gunicorn hypercorn daphne,$(foreach workers, 1 2 3 4 5 6 7 8,$(call benchmark,$(server),$(workers));))

define benchmark
	$(MAKE) -C ../.. all server=$(1) app=fastapi workers=$(2)
	$(MAKE) all server=$(1) app=fastapi workers=$(2)
	$(MAKE) -C ../.. clean server=$(1) app=fastapi
endef
