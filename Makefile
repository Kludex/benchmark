network = data

all: build network run

build:
	docker build --build-arg SERVER=$(server) --build-arg APP=$(app) -t $(server)-$(app) .

network:
	docker network create $(network) || true

workers ?= 1
run:
	docker run --rm -d --network $(network) -e WORKERS=$(workers) --name $(server)-$(app) $(server)-$(app)

study:
	$(MAKE) -C cases/$(case)

clean:
	docker stop $(server)-$(app)
	docker network rm $(network)
