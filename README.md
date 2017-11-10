# SPEEDO

(Ron's logo here)

### A database for performance car info
#### By gearheads, for gearheads
### Built by Geoff Colman and Ronald Uy

## § 2.1

How many of us grew up coveting any of a huge number of iconic cars? Perhaps a 1957 Corvette? Or a 1967 Mustang? The “Me Generation” of the ‘80s likely yearned for something more along the lines of Thomas Magnum’s (well, Robin Masters’) Ferrari 308 GTS or Lamborghini Countach. Millennials might identify more with a 2004 Porsche Carrera GT or a 2008 Nissan GT-R. Whatever the vehicle, there is no denying the visceral appeal, the _magnetism_ of beautiful, powerful sports cars. They can evoke emotions from multiple levels of human consciousness, from the heady, technical appeal of the advanced engineering of a computer-controlled center differential to the animal lust of a roaring Italian V-12 engine. It is for this reason that we sought to create a database cataloging a variety of information - both “demographic” particulars (items such as curb weight and dimensions) and performance - about the finest machines ever to grace a blacktop.

Potential users of this system will be, broadly, anyone interested in automobiles. More specifically, we have a few specific subcategories thereof in mind: we want to make it easy for “car junkies” or “gearheads,” motorsport enthusiasts, and new or novice drivers looking to learn more about high-performance cars to look up a variety of information about a chosen vehicle. Additionally, as racing video games and simulations become more and more advanced and realistic, with more and more sophisticated physics engines, we see our system as a valuable reference tool. Players or participants will be able to easily look up information about a potential car they wish to test-drive within the game or simulator, even if that data isn’t readily available within the constraints of the game or simulation.

We will be using the MySQL database engine, as its performance and high portability makes it ideal for scalability (car manufacturers will continually produce new models, so new data will need to be added at least once each model-year), or for users who wish to expand upon our implementation. For maximum generality, our system is intended to be "forward-compatible," or expandable should potential future users/customers wish to add additional performance metrics, vehicle specifics, or information about manufacturers.



## § 2.2

We will be compiling vehicle metrics and performance-related data - such as top speed, acceleration, and engine power output - for a given vehicle make and model. Descriptive and performance metrics will be quoted in their respective industry standard Imperial units of measurement - pounds, inches, miles per hour, horsepower, etc.

#### Manufacturer Table: 
- Manufacturer Index (Primary Key)
  - An arbitrary integer generated for the express purpose of serving as a unique identifier for each manufacturer.
- Manufacturer Name
  - A character string containing the common name (i.e., omitting any "Motors," "Company," etc. suffixes) of the car brand in question.
- Country of Origin
  - A character string containing the English name of the country in which the manufacturer is based, and some have been abbreviated. The United States, for example, is "USA."

#### Car Table
- Manufacturer Index
  - A foreign key into the Manufacturer Table, to match a car with its manufacturer.
- Car Index (Primary Key)
  - An arbitrary integer generated for the express purpose of serving as a unique identifier for each car.
- Model
  - A character string consisting of the common American name of the car along with any potential modifiers ("GT," "Sport," etc.).
- Year
  - A 4-digit integer consisting of the Gregorian model-year of the specific car from which the data were drawn.
- MSRP
  - An integer expressing (suggested) US retail price of the car from dealers (rounded to the nearest dollar) at the time of its manufacture and sale. For "legacy" vehicles built prior to the 21st century, this value will not be readily comparable to that of newer cars, and - as with some extremely exclusive contemporary cars for which no exact price is readily available - some approximations have been made with the source data.
- Performance Index
  - A foreign key into the Performance Table, to match a car with its relevant performance data.

#### Performance Table:
- Performance Index (Primary Key)
  - An arbitrary integer generated for the express purpose of serving as a unique identifier for each row of performance data.
- Top speed
  - A floating point number expressing the car's maximum speed in miles per hour (mph).
- Acceleration
  - A floating point number expressing the number of seconds the car takes to reach 60 mph (though data for European cars sometimes references 62 mph due to the imperfect Imperial/SI conversion) from a standing start.
- Horsepower
  - An integer expressing the car's engine's peak power output in Imperial brake horsepower (bhp).
- Weight
  - An integer expressing the car's curb weight (laden with all relevant fluids) in pounds.
- Wheelbase
  - A floating point value expressing the distance between the front and rear wheel centerlines in inches. This, rather than overall length, is the "effective" length of the car for handling purposes.
- Track
  - A floating point value expressing the distance between the left and right wheel hubs in inches. This, rather than overall width, is the "effective" width of the car for handling purposes, but overall width has been occasionally used where the actual track data is not readily available. In situations in which the front and rear tracks are not identical, the average of the two has been given.

## § 1.3

Say, for example, a user wishes to look up cars with 0-60 acceleration times of less than 5 seconds. Then they could compose a query something to the effect of:

```SQL
SELECT * FROM Car WHERE ZeroSixty < 5
```

Of course, this could potentially return a large variety of cars. What if a specific subset of users are only interested in cars that were manufactured by Ferrari? Then they could do something like this:

```SQL
SELECT * FROM Car WHERE Make='Ferrari'
```

If they wish to combine the two queries, and refine the result to return only the names of those Ferrari models capable of 0-60 acceleration of less than 5 seconds, then the following query should give it to them:


```SQL
SELECT Model FROM Car WHERE ZeroSixty < 5 AND Make="Ferrari"
```

Now let's look at something else. So far, we've only examined one type of performance data. What if the user wants to know which cars that are capable of a given minimum top speed and have very fast acceleration off the line, but isn't interested in the rest of the data for that car?

```SQL
SELECT Make, Model FROM Car WHERE ZeroSixty < 5 AND TopSpeed >= 150
```

Lastly, let's look at a potential edge case. No one should _really_ care only about the vehicles' “demographic” data; what if someone wanted to examine only the weights of every car in the database, perhaps for statistical analysis? Naturally, this is possible:

```SQL
SELECT Weight FROM Car
```

The possibilities are limited only by the user's imagination and the available data.

## § 1.4

Our schema will look a little something like this:

#### Manufacturer Table: 
- Manufacturer Index (Primary Key)
- Manufacturer Name
- Country of Origin

#### Car Table
- Manufacturer Index
- Car Index (Primary Key) 
- Model
- Year
- MSRP
- Performance Index

#### Performance Table:
- Performance Index (Primary Key)
- Top speed (mph)
- 0-60 acceleration time
- Horsepower (bhp)
- Weight
- Dimensions

The Manufacturer table contains information about the manufacturers of the cars themselves. The Car table contains all of the identifying and demographic information about the car, as well as relations to their respective manufacturers and performance data. The Performance table contains the meat of our project: all of the actual performance data for every car in our database.

The various "indices" are arbitrary integers that serve to normalize the data, as well as provide unique primary keys for both the cars and arbitrary numerical performance data. The rest of the attributes should be relatively self-explanatory.

## § 1.5

![Entity-Relationship Diagram](https://github.com/ronaldooeee/CMSI-486/blob/master/Final%20ERD%20for%20Database%20Project.png)
