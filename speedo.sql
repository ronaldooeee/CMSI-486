CREATE DATABASE IF NOT EXISTS speedo;

CREATE TABLE IF NOT EXISTS car (
      car_id            int             PRIMARY KEY     # Arbitrary index
    , manufacturer_id   int             FOREIGN KEY     # Foreign key into manufacturer table
    , model             VARCHAR(32)                     # Longest current name is 16, but should anticipate growth/refactoring
    , year              int(4)                          # It's highly unlikely this system will still be in use in the year 10000
    , msrp              int                             # With a max value of around 4x10^9, this should suffice for the foreseeable future
    , performance_id    int             FOREIGN KEY     # Foreign key into performance table
    );

CREATE TABLE IF NOT EXISTS manufacturer (
      manufacturer_id   int             PRIMARY KEY     # Arbitrary index
    , manufacturer_name VARCHAR(32)                     # Longest current name is 13, but should anticipate growth/refactoring
    , country           VARCHAR(32)                     # Longest current name is 7, but should anticipate growth/refactoring
    );

CREATE TABLE IF NOT EXISTS performance (
      performance_id    int             PRIMARY KEY     # Arbitrary index
    , top_speed         int(3)                          # In mph -- if this number should ever exceed 3 digits, I'll eat my hat
    , acceleration      decimal(3, 2)                   /* 0-60 in seconds; 3 total digits, 2 after the decimal point --
                                                           It's highly unlikely we'll ever include a vehicle with a 0-60 time greater than 10 seconds,
                                                             and real-world timekeeping limitations dictate a precision of tenths of a second */
    , bhp               int(4)                          /* Net engine output in mechanical/brake horsepower --
                                                           The *absolute* upper-bound for this at humanity's current level of technology seems to be around 1200 */
    , weight            int(4)                          # In pounds; the sorts of cars we're covering tend to range from 3100 - 3700
    , wheelbase         decimal(5, 2)                   /* In inches; 5 total digits, 3 after the decimal point -- 
                                                           Numbers tend to range from 90 - 120, with varying floating point precision */
    , track             decimal(4, 2)                   /* In inches; 4 total digits, 2 after the decimal point --
                                                           Numbers tend to range from 65 - 80, with varying floating point precision */
    );
