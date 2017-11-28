# SPEEDO

(Ron's logo here)

### A database for performance car info
#### By gearheads, for gearheads
### Built by Geoff Colman and Ronald Uy

## Table of Contents

[I. Introduction](#introduction)
[II. Schema/Data Dictionary](#schema)
  [A. Manufacturer Table](#manufacturer-table-)
  [B. Car Table](#car-table-)
  [C. Performance Table](#performance-table-)
[III. Examples](#examples)
[IV. Entity-Relationship Diagram](#erd)

## Introduction

How many of us grew up coveting any of a huge number of iconic cars? Perhaps a 1957 Corvette? Or a 1967 Mustang? The “Me Generation” of the ‘80s likely yearned for something more along the lines of Thomas Magnum’s (well, Robin Masters’) Ferrari 308 GTS or Lamborghini Countach. Millennials might identify more with a 2004 Porsche Carrera GT or a 2008 Nissan GT-R. Whatever the vehicle, there is no denying the visceral appeal, the _magnetism_ of beautiful, powerful sports cars. They can evoke emotions from multiple levels of human consciousness, from the heady, technical appeal of the advanced engineering of a computer-controlled center differential to the animal lust of a roaring Italian V-12 engine. It is for this reason that we sought to create a database cataloging a variety of information - both “demographic” particulars (items such as curb weight and dimensions) and performance - about the finest machines ever to grace a blacktop.

Potential users of this system will be, broadly, anyone interested in automobiles. More specifically, we have a few specific subcategories thereof in mind: we want to make it easy for “car junkies” or “gearheads,” motorsport enthusiasts, and new or novice drivers looking to learn more about high-performance cars to look up a variety of information about a chosen vehicle. Additionally, as racing video games and simulations become more and more advanced and realistic, with more and more sophisticated physics engines, we see our system as a valuable reference tool. Players or participants will be able to easily look up information about a potential car they wish to test-drive within the game or simulator, even if that data isn’t readily available within the constraints of the game or simulation.

We will be using the MySQL database engine, as its performance and high portability makes it ideal for scalability (car manufacturers will continually produce new models, so new data will need to be added at least once each model-year), or for users who wish to expand upon our implementation. For maximum generality, our system is intended to be "forward-compatible," or expandable should potential future users/customers wish to add additional performance metrics, vehicle specifics, or information about manufacturers.

## Schema

We will be compiling vehicle metrics and performance-related data - such as top speed, acceleration, and engine power output - for a given year of vehicle make and model. Descriptive and performance metrics will be quoted in their respective industry standard Imperial units of measurement - pounds, inches, miles per hour, horsepower, etc.

Data will be normalized across 3 tables for maximum flexibility and generality, with an eye to extensibility. The Manufacturer table contains information about the manufacturers of the cars, the Car table contains all of the identifying and demographic information about the cars (and indices into their respective manufacturers and performance data), and the Performance table contains the meat of our project: all of the actual performance data for every car in our database. We have made the design decision to separate the performance data from the demographic data on the basis that many models' performance may not change substantially from year-to-year, but the price may increase due to business considerations.

The various "indices" are arbitrary integers that serve as relations across the 3 tables, normalizing the data and providing unique primary keys for the cars, the manufacturers, and the arbitrary numerical performance data. The rest of the attributes should be relatively self-explanatory, but further details are discussed below.

#### Manufacturer Table: <a name='manufacturer-table'></a>
- Manufacturer Index (manufacturer_id) **(Primary Key)**
  - An arbitrary integer generated for the express purpose of serving as a unique identifier for each manufacturer.
- Manufacturer Name (manufacturer_name)
  - A 32-byte character string containing the common English name (i.e., omitting any "Motors," "Company," etc. suffixes) of the car brand in question.
- Country of Origin (country)
  - A 32-byte character string containing the common English name of the country in which the manufacturer is based, with some abbreviations. The United States, for example, is "USA."

#### Car Table: <a name='car-table'></a>
- Manufacturer Index (manufacturer_id)
  - A foreign key into the Manufacturer table, to match a car with its manufacturer.
- Car Index (car_id) **(Primary Key)**
  - An arbitrary integer generated for the express purpose of serving as a unique identifier for each car.
- Model (model)
  - A 32-byte character string consisting of the common American name of the car along with any potential modifiers ("GT," "Sport," etc.) that are considered an integral part of the common name. For example, given the myriad variations of the Bugatti Veyron, the respective model names in our database will include the "16.4"/"Grand Sport"/etc. suffixes.
- Year (year)
  - A 4-byte integer consisting of the Gregorian model-year of the specific car from which the data were drawn.
- MSRP (msrp)
  - An integer expressing (suggested) US retail price of the car from dealers (rounded to the nearest dollar) at the time of its manufacture and sale. For "legacy" vehicles (such as those built prior to the 21st century), this value will not be readily comparable to that of newer cars, and - as with some extremely exclusive contemporary cars for which no exact price is readily available - some approximations have been made with the source data.
- Performance Index (performance_id)
  - A foreign key into the Performance table, to match a car with its relevant performance data.

#### Performance Table: <a name='performance-table'></a>
- Performance Index (performance_id) **(Primary Key)**
  - An arbitrary integer generated for the express purpose of serving as a unique identifier for each row of performance data.
- Top speed (top_speed)
  - A 3-byte integer expressing the car's maximum speed in miles per hour (mph) rounded to the nearest whole number.
- Acceleration (acceleration)
  - A floating point number expressing the number of seconds the car takes to reach 60 mph (though data for European cars sometimes references 62 mph due to the imperfect Imperial/SI conversion) from a standing start.
- Horsepower (bhp)
  - A 4-byte integer expressing the car's engine's peak power output in Imperial brake horsepower (bhp).
- Weight (weight)
  - A 4-byte integer expressing the car's curb weight (laden with all relevant fluids) in pounds.
- Wheelbase (wheelbase)
  - A floating point value expressing the distance between the front and rear wheel centerlines in inches. This, rather than overall length, is the "effective" length of the car for handling purposes.
- Track (track)
  - A floating point value expressing the distance between the left and right wheel hubs in inches. This, rather than overall width, is the "effective" width of the car for handling purposes, but overall width has been occasionally used where the actual track data is not readily available. In situations in which the front and rear tracks are not identical, the average of the two has been given.

## Examples

Say, for example, a user wishes to look up all the data for cars with 0-60 acceleration times of less than 5 seconds. Then they could compose a query something to the effect of:

```SQL
SELECT * FROM car NATURAL JOIN manufacturer NATURAL JOIN performance WHERE acceleration < 5;
```

Of course, this could potentially return a large variety of cars. What if a specific subset of users are only interested in seeing all the data for cars that were manufactured by Ferrari? Then they could do something like this:

```SQL
SELECT * FROM car NATURAL JOIN manufacturer NATURAL JOIN performance WHERE manufacturer_name='Ferrari';

```

If they wish to combine the two queries, and refine the result to return only the names of those Ferrari models capable of 0-60 acceleration of less than 5 seconds, then the following query should give it to them:

```SQL
SELECT model FROM car NATURAL JOIN manufacturer NATURAL JOIN performance WHERE acceleration < 5 AND manufacturer_name='Ferrari';
```

Now let's look at something else. So far, we've only examined one type of performance data. What if the user wants to know which cars that are capable of a given minimum top speed and have very fast acceleration off the line, but isn't interested in the rest of the data for that car?

```SQL
SELECT manufacturer_name, model FROM car NATURAL JOIN manufacturer NATURAL JOIN performance WHERE acceleration < 5 AND top_speed >= 150;
```

Lastly, let's look at a potential edge case. No one should *really* care only about the vehicles' “demographic” data; what if someone wanted to examine only the weights of every car in the database, perhaps for statistical analysis? Naturally, this is possible:

```SQL
SELECT weight FROM car NATURAL JOIN performance;
```

The possibilities are limited only by the user's imagination and the available data.

## Entity-Relationship Diagram <a name='erd'></a>

![Entity-Relationship Diagram](https://github.com/ronaldooeee/CMSI-486/blob/master/Final%20ERD%20for%20Database%20Project.png)
