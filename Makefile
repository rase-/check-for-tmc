
CHECK_CFLAGS=$(shell pkg-config --cflags check)
CHECK_LDFLAGS=$(shell pkg-config --libs check)
SRC_FILES=tmc-check-example.c tmc-check.c
HEADER_FILES=tmc-check.h

all: tmc-check-example

tmc-check-example: $(SRC_FILES) $(HEADER_FILES)
	gcc $(CHECK_CFLAGS) -Wall -o $@ $(SRC_FILES) $(CHECK_LDFLAGS)

clean:
	rm -f tmc-check-example tmc_available_points.txt tmc_test_results.xml tmc_memory_test_info.txt

run-example: tmc-check-example
	# Printing available points
	./tmc-check-example --print-available-points
	# Running test. There should be one success and one failure.
	./tmc-check-example
