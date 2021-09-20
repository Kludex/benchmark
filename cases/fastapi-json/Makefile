network = data
.DEFAULT_GOAL := run

api:
	docker run --network $(network) \
	-e APP=$(app) -e SERVER=$(server) -e FILENAME=/results/api.csv \
	-v $(shell pwd)/results:/results -v $(shell pwd)/wrk:/scripts \
	williamyeh/wrk http://$(server)-$(app):8080/api/users/1/records/1?query=test -d60s -t4 -c64 -s /scripts/api.lua

run:
	$(foreach app, fastapi fastapi-orjson fastapi-ujson fastapi-rapidjson, $(call benchmark,$(app);))

define benchmark
	$(MAKE) -C ../.. all server=uvicorn app=$(1)
	$(MAKE) api server=uvicorn app=$(1)
	$(MAKE) -C ../.. clean server=uvicorn app=$(1)
endef
