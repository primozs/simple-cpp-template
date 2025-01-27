
CC = g++
CFLAGS = -std=c++20 -Wall -Wextra -Wfloat-equal -Wshadow -Wconversion -Wpedantic -Werror=type-limits -fsanitize=undefined,address

.PHONY: all
all: clean ./bin/program

.PHONY: init
init:
	mkdir -p bin

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

# https://github.com/catchorg/Catch2/blob/v2.x/docs/slow-compiles.md
.PHONY: tests
tests: init ./bin/tests	

./bin/tests: ./bin/tests_main.o tests/tests.cpp
	@echo "Run tests"
	${CC} $(CTESTSFLAGS) $^ -o $@
	$@
	# $@ -r compact

./bin/tests_main.o: tests/main.cpp
	@echo "Compiling test main"
	${CC} ${CTESTSFLAGS} -c $< -o $@

./bin/tests.o: tests/tests.cpp
	@echo "Compiling tests.cpp"
	${CC} ${CTESTSFLAGS} -c $< -o $@
