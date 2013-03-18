
#include <check.h>
#include <stdio.h>

/***** Main API *****/

/** A shorthand to make one test suite with the given points */
Suite* tmc_suite_create(const char *name, const char *points);

/** A shorthand to make a one function testcase with the given points into a suite. */
#define tmc_register_test(suite, tf, points) _tmc_register_test((suite), (tf), "" # tf, points)
void _tmc_register_test(Suite *s, TFun tf, const char *fname, const char *points);

/** A shorthand to make one memory test for a test function with given parameters */
#define tmc_register_memtest(tf, check_leaks, max_bytes_allocated) _tmc_register_memtest("" # tf, check_leaks, max_bytes_allocated)
void _tmc_register_memtest(const char *tf_name, int chek_leaks, int max_bytes_allocated);

/** A shorthand for registering a test with memtest at the same time */
#define tmc_register_test_with_memtest(suite, tf, points, check_leaks, max_bytes_allocated)  tmc_register_test(suite, tf, points); tmc_register_memtest(tf, check_leaks, max_bytes_allocated)

/**
 * Runs a test suite so that tmc_test_results.xml and tmc_test_points.txt are created.
 *
 * To be called from main() after creating the Suite.
 *
 * If --print-available-points is given, it only outputs all available points
 * (in an undefined order) to stdout and exits.
 *
 * Returns an error code that can be returned from main.
 * Normally this will be 0 even if test fail.
 */
int tmc_run_tests(int argc, const char **argv, Suite *s);


/***** Low-level API *****/

/**
 * Set the points of a test case.
 *
 * This is a lower level alternative to using tmc_register_test.
 */
void tmc_set_tcase_points(TCase *tc, const char *tc_name, const char *points);

/**
 * Set the points of a test suite
 *
 * This is a lower level alternative to using tmc_suite_create.
 */
void tmc_set_suite_points (Suite *s, const char *s_name, const char *points);

/** Prints all registered points once (in no particular order) to the given file. */
int tmc_print_available_points(FILE *f, char delimiter);
int tmc_print_memory_tests(FILE *f, char attr_delimiter, char line_delimiter);

/** Prints lines like "[test] testname pointname1 pointname2" to the given file. */
int tmc_print_test_points(FILE *f);
/** Prints lines with "[suite] suitename pointname1 pointname2" to given file */
int tmc_print_suite_points(FILE *f);