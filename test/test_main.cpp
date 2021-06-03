#define CATCH_CONFIG_MAIN
#include <stdio.h>
#include "catch_amalgamated.hpp"

TEST_CASE("Testing Catch") {
    REQUIRE( 1 == 1 );
    REQUIRE( 2 == 2 );
    REQUIRE( 3 == 4 );
}