# SPEEDO

(Ron's logo here)

### A database for performance car info
#### By gearheads, for gearheads
### Built by Geoff Colman and Ronald Uy

## § 1.1

How many of us grew up coveting any of a huge number of iconic cars? Perhaps a 1957 Corvette? Or a 1967 Mustang? The “Me Generation” of the ‘80s likely yearned for something more along the lines of Thomas Magnum’s (well, Robin Masters’) Ferrari 308 GTS or Lamborghini Countach. Millennials might identify more with a 2004 Porsche Carrera GT or a 2008 Nissan GT-R. Whatever the vehicle, there is no denying the visceral appeal, the _magnetism_ of beautiful, powerful sports cars. They can evoke emotions from multiple levels of human consciousness, from the heady, technical appeal of the advanced engineering of a computer-controlled center differential to the animal lust of a roaring Italian V-12 engine. It is for this reason that we sought to create a database cataloging a variety of information - both “demographic” particulars (items such as curb weight and dimensions) and performance - about the finest machines ever to grace a blacktop.

Potential users of this system will be, broadly, anyone interested in automobiles. More specifically, we have a few specific subcategories thereof in mind: we want to make it easy for “car junkies” or “gearheads,” motorsport enthusiasts, and new or novice drivers looking to learn more about high-performance cars to look up a variety of information about a chosen vehicle. Additionally, as racing video games and simulations become more and more advanced and realistic, with more and more sophisticated physics engines, we see our system as a valuable reference tool. Players or participants will be able to easily look up information about a potential car they wish to test-drive within the game or simulator, even if that data isn’t readily available within the constraints of the game or simulation.

## § 1.2

We will be compiling various vehicle metrics and performance-related data - such as top speed, acceleration, engine output (i.e., power/torque), braking distance, and the like - for a given vehicle make and model. Descriptive and performance metrics will be quoted in their respective industry standard units of (typically Imperial) measurement - pounds/pound-feet, miles per hour, horsepower, etc.

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

![alt text](https://github.com/ronaldooeee/CMSI-486/blob/master/Preliminary%20ERD%20for%20Database%20Project.png)
