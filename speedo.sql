CREATE DATABASE IF NOT EXISTS speedo;                               # First ensure that user has priveleges to do so!
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

/*
Depending upon user preference, specifically with regard to which particular system/interface the user employs,
  there are 3 ways to load our data into the working database:

  1. Directly import our raw .CSV data files using the import feature of the phpMyAdmin client application (our recommendation).
  2. Failing that, or if the user does not wish to utilize phpMyAdmin, load the data from said raw files using MySQL data definition language.
     Find the comment block immediately below bookended by the "------(2)------" marker comments, and remove the multi-line comment tokens surrounding it.
  3. Insert the data row-by-row using MySQL data definition language. We do not specifically recommend this, as it does not promote easy extensibility or scalability.
     Find the comment block immediately below bookended by the "------(3)------" marker comments, and remove the multi-line comment tokens surrounding it.
*/

/*
# ------(2)------

LOAD DATA INFILE '/data/manufacturer.csv' INTO TABLE manufacturer
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES;
LOAD DATA INFILE '/data/car.csv' INTO TABLE car
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES;
LOAD DATA INFILE '/data/performance.csv' INTO TABLE performance
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES;

# ------(2)------
*/

/*
# ------(3)------
INSERT INTO manufacturer VALUES (1,  'Bugatti',          'France');
INSERT INTO manufacturer VALUES (2,  'Audi',             'Germany');
INSERT INTO manufacturer VALUES (3,  'BMW',              'Germany');
INSERT INTO manufacturer VALUES (4,  'Mercedes-Benzy',   'Germany');
INSERT INTO manufacturer VALUES (5,  'Porsche',          'Germany');
INSERT INTO manufacturer VALUES (6,  'Ferrari',          'Italy');
INSERT INTO manufacturer VALUES (7,  'Maserati',         'Italy');
INSERT INTO manufacturer VALUES (8,  'Lamborghini',      'Italy');
INSERT INTO manufacturer VALUES (9,  'Honda',            'Japan');
INSERT INTO manufacturer VALUES (10, 'Lexus',            'Japan');
INSERT INTO manufacturer VALUES (11, 'Nissan',           'Japan');
INSERT INTO manufacturer VALUES (12, 'Chevrolet',        'USA');
INSERT INTO manufacturer VALUES (13, 'Dodge',            'USA');
INSERT INTO manufacturer VALUES (14, 'Ford',             'USA');
INSERT INTO manufacturer VALUES (15, 'Pontiac',          'USA');
INSERT INTO manufacturer VALUES (16, 'Saleen',           'USA');
INSERT INTO manufacturer VALUES (17, 'Shelby',           'USA');
INSERT INTO manufacturer VALUES (18, 'Bentley',          'United Kingdom');
INSERT INTO manufacturer VALUES (19, 'McLaren',          'United Kingdom');

INSERT INTO car VALUES (1,   6, '360 Modena',       1999,   160125,     1);
INSERT INTO car VALUES (2,   6, '360 Spider',       1999,   172186,     1);
INSERT INTO car VALUES (3,   6, 'Enzo',             2002,   659330,     2);
INSERT INTO car VALUES (4,   5, 'Carrera GT',       2005,   448000,     3);
INSERT INTO car VALUES (5,   3, 'M1',               1978,   115000,     4);
INSERT INTO car VALUES (6,   8, 'Countach LP500 S', 1982,   99000,      5);
INSERT INTO car VALUES (7,   6, '308 GTS',          1981,   58555,      6);
INSERT INTO car VALUES (8,  14, 'Mustang',          1967,   2500,       7);
INSERT INTO car VALUES (9,  17, 'GT500',            1968,   4000,       8);
INSERT INTO car VALUES (10, 11, 'GT-R',             2008,   69850,      9);
INSERT INTO car VALUES (11,  1, 'Veyron 16.4',      2005,   1240000,    10);
INSERT INTO car VALUES (12,  2, 'R8 V10',           2009,   162500,     11);
INSERT INTO car VALUES (13,  4, 'SLR McLaren',      2009,   495000,     12);
INSERT INTO car VALUES (14,  7, 'GranTurismo',      2017,   132825,     13);
INSERT INTO car VALUES (15,  9, 'NSX',              1992,   60600,      14);
INSERT INTO car VALUES (16, 10, 'LFA',              2012,   375000,     15);
INSERT INTO car VALUES (17,  1, 'Veyron 16.4',      2011,   1240000,    10);
INSERT INTO car VALUES (18, 12, 'Corvette',         1957,   3176,       16);
INSERT INTO car VALUES (19, 12, 'Corvette ZR-1',    1990,   58995,      17);
INSERT INTO car VALUES (20, 12, 'Corvette ZR-1',    2010,   106880,     18);
INSERT INTO car VALUES (21, 13, 'Viper RT/10',      2002,   72225,      19);
INSERT INTO car VALUES (22, 13, 'Viper SRT/10',     2003,   79995,      20);
INSERT INTO car VALUES (23, 15, 'GTO',              1967,   4500,       21);
INSERT INTO car VALUES (24, 15, 'GTO',              2006,   31290,      22);
INSERT INTO car VALUES (25, 16, 'S7',               2006,   580000,     23);
INSERT INTO car VALUES (26,  8, 'Huracán',          2018,   284000,     24);
INSERT INTO car VALUES (27,  4, 'AMG GT R',         2018,   158000,     25);
INSERT INTO car VALUES (28,  9, 'Civic Type R',     2017,   34775,      26);
INSERT INTO car VALUES (29, 10, 'LC 500',           2018,   93000,      27);
INSERT INTO car VALUES (30, 18, 'Continental GT',   2017,   231000,     28);
INSERT INTO car VALUES (31, 19, '720S',             2018,   289000,     29);

INSERT INTO performance VALUES (1,  175,    4.6,    395,    3424,   102.4,  64.7);
INSERT INTO performance VALUES (2,  221,    3.14,   651,    3260,   104,    80.1);
INSERT INTO performance VALUES (3,  205,    3.6,    603,    3146,   107,    75.6);
INSERT INTO performance VALUES (4,  162,    5.6,    273,    2866,   102.4,  71.8);
INSERT INTO performance VALUES (5,  182,    5.2,    370,    3263,   96.5,   78.7);
INSERT INTO performance VALUES (6,  140,    7.8,    252,    3327,   92,     68);
INSERT INTO performance VALUES (7,  128,    7.4,    225,    2758,   108,    70.9);
INSERT INTO performance VALUES (8,  128,    6.5,    360,    3370,   108,    70.9);
INSERT INTO performance VALUES (9,  195,    3.5,    480,    3840,   109.4,  74.6);
INSERT INTO performance VALUES (10, 253,    2.4,    1006,   4162,   106.7,  78.7);
INSERT INTO performance VALUES (11, 196,    3.9,    525,    3580,   104.3,  76);
INSERT INTO performance VALUES (12, 208,    3.5,    617,    3850,   110,    75.14);
INSERT INTO performance VALUES (13, 185,    4.7,    454,    4350,   115.8,  62.5);
INSERT INTO performance VALUES (14, 168,    5.7,    270,    3010,   99.6,   71.3);
INSERT INTO performance VALUES (15, 203,    3.6,    553,    3559,   102.6,  74.6);
INSERT INTO performance VALUES (16, 132,    5.7,    283,    2849,   102,    70.5);
INSERT INTO performance VALUES (17, 180,    4.4,    375,    3240,   96.2,   71);
INSERT INTO performance VALUES (18, 205,    3.5,    638,    3373,   105.7,  75.9);
INSERT INTO performance VALUES (19, 185,    4,      450,    3442,   96.2,   75.7);
INSERT INTO performance VALUES (20, 190,    3.8,    500,    3380,   98.8,   75.7);
INSERT INTO performance VALUES (21, 120,    5.2,    360,    3425,   115,    74.4);
INSERT INTO performance VALUES (22, 188,    4.6,    400,    3725,   109.8,  72.5);
INSERT INTO performance VALUES (23, 248,    2.8,    750,    2968,   106.3,  78.35);
INSERT INTO performance VALUES (24, 202,    2.4,    630,    3546,   103.1,  75.8);
INSERT INTO performance VALUES (25, 198,    3.3,    577,    3668,   103.5,  79);
INSERT INTO performance VALUES (26, 170,    5.1,    306,    3106,   106.3,  73.9);
INSERT INTO performance VALUES (27, 168,    4.6,    471,    4378,   108.3,  75.6);
INSERT INTO performance VALUES (28, 198,    4.4,    567,    5115,   108.1,  76.5);
INSERT INTO performance VALUES (29, 212,    2.7,    710,    3153,   103.9,  76);
# ------(3)------
*/