
CC = g++
CFLAGS = -std=c++20 -Wall -Wextra -Wfloat-equal -Wshadow -Wconversion -Wpedantic -fsanitize=undefined,address

.PHONY: all
all: ./bin/program

./bin/program:
	@echo "Build"
	mkdir -p bin
	${CC} -ggdb ${CFLAGS} src/main.cpp -o $@

.PHONY: release
release: init
	@echo "Build release"
	mkdir -p bin
	${CC} -O2 -DNDEBUG ${CFLAGS} src/main.cpp -o ./bin/release

.PHONY: clean
clean:
	@echo "Cleanup"
	rm -rf bin
