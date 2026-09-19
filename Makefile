IMAGE   ?= stm32-build
DOCKER  ?= docker
UID     := $(shell id -u)
GID     := $(shell id -g)
RUN      = $(DOCKER) run --rm -v $(PWD):/workspace -w /workspace --user $(UID):$(GID) $(IMAGE)

ELF     := firmware/build/firmware.elf

.PHONY: all image build rebuild clean size shell

all: build

image:
	$(DOCKER) build -t $(IMAGE) docker/

build:
	$(RUN) make -C firmware all

rebuild: clean build

clean:
	$(RUN) make -C firmware clean

size:
	$(RUN) arm-none-eabi-size $(ELF)

shell:
	$(DOCKER) run --rm -it -v $(PWD):/workspace -w /workspace --user $(UID):$(GID) $(IMAGE) bash

