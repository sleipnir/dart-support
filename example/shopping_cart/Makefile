image=sleipnir/dart-shoppingcart:0.5.6

.PHONY: all clean

all: build install

run:

	dart bin/main.dart

build:

	docker build -t ${image} . 

install:

	docker push ${image}

	
