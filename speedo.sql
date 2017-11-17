CREATE DATABASE IF NOT EXISTS speedo;
USE speedo;

CREATE TABLE IF NOT EXISTS car (
      car_id            INT             NOT NULL    AUTO_INCREMENT  # Arbitrary index
    , manufacturer_id   INT                                         # Foreign key into manufacturer table
    , model             VARCHAR(32)                                 # Longest current name is 16, but should anticipate growth/refactoring
    , year              INT(4)                                      # It's highly unlikely this system will still be in use in the year 10000
    , msrp              INT                                         # With a max value of around 4x10^9, this should suffice for the foreseeable future
    , performance_id    INT                                         # Foreign key into performance table
    , PRIMARY KEY (car_id)
    );

CREATE TABLE IF NOT EXISTS manufacturer (
      manufacturer_id   INT             NOT NULL    AUTO_INCREMENT  # Arbitrary index
    , manufacturer_name VARCHAR(32)                                 # Longest current name is 13, but should anticipate growth/refactoring
    , country           VARCHAR(32)                                 # Longest current name is 7, but should anticipate growth/refactoring
    , PRIMARY KEY (manufacturer_id)
    );

CREATE TABLE IF NOT EXISTS performance (
      performance_id    INT             NOT NULL    AUTO_INCREMENT  # Arbitrary index
    , top_speed         INT(3)                                      # In mph -- if this number should ever exceed 3 digits, I'll eat my hat
    , acceleration      DECIMAL(3, 2)                               /* 0-60 in seconds; 3 total digits, 2 after the decimal point --
                                                                       It's highly unlikely we'll ever include a vehicle with a 0-60 time greater than 10 seconds,
                                                                         and real-world timekeeping limitations dictate a precision of tenths of a second */
    , bhp               INT(4)                                      /* Net engine output in mechanical/brake horsepower --
                                                                       The *absolute* upper-bound for this at humanity's current level of technology seems to be around 1200 */
    , weight            INT(4)                                      # In pounds; the sorts of cars we're covering tend to range from 3100 - 3700
    , wheelbase         DECIMAL(5, 2)                               /* In inches; 5 total digits, 3 after the decimal point -- 
                                                                       Numbers tend to range from 90 - 120, with varying floating point precision */
    , track             DECIMAL(4, 2)                               /* In inches; 4 total digits, 2 after the decimal point --
                                                                       Numbers tend to range from 65 - 80, with varying floating point precision */
    , PRIMARY KEY (performance_id)
    );
