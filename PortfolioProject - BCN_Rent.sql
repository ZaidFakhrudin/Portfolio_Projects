SELECT * FROM barcelona_rent_working;

-- Finding the average rent/month as well as rent/square for each year
-- dataset offers rent prices per month and per square

-- need to split code into 2 (one for monthly price, one for square meter price)

# MONTHLY PRICE

SELECT year, ROUND(AVG(price), 2) AS rent_per_month
FROM barcelona_rent_working
WHERE average_rent = 'average rent (euro/month)'
GROUP BY year;

# PER SQUARE PRICE

SELECT year,ROUND(AVG(price),2) AS rent_per_square
FROM barcelona_rent_working
WHERE average_rent = 'average rent per surface (euro/m2)'
GROUP BY year;

-- Now that we have the results for each rent type, we will create a view for each and combine them into one

CREATE VIEW rent_month AS
SELECT year,ROUND(AVG(price),2) AS rent_per_month
FROM barcelona_rent_working
WHERE average_rent = 'average rent (euro/month)'
GROUP BY year;

CREATE VIEW rent_per_square AS
SELECT year,ROUND(AVG(price),2) AS rent_per_square
FROM barcelona_rent_working
WHERE average_rent = 'average rent per surface (euro/m2)'
GROUP BY year;

-- joining both sets of views to create another set of view that compares both price types side by side

CREATE VIEW rent_overview AS
SELECT rent_month.year, rent_month.rent_per_month, rent_per_square.rent_per_square FROM rent_month
JOIN rent_per_square
ON rent_month.year = rent_per_square.year;

-- visualize views created into line charts to look at development of trends

-- Now we know the rent overview for the years, I would like to find out the rent for each district and how they develop over the years. 
-- To do that, we need to understand the mean/average for each of the 10 districts. We'll look into their rent price per square meter trend 

# PER SQUARE PRICE BY DISTRICT

SELECT year,
ROUND(AVG(CASE WHEN district = 'Ciutat Vella' THEN price END),2) AS 'Ciutat Vella',
ROUND(AVG(CASE WHEN district = 'Eixample' THEN price END),2) AS 'Eixample',
ROUND(AVG(CASE WHEN district = 'Sants-Montjuic' THEN price END),2) AS 'Sants-Montjuic',
ROUND(AVG(CASE WHEN district = 'Les Corts' THEN price END),2) AS 'Les Corts',
ROUND(AVG(CASE WHEN district = 'Sarria-Sant Gervasi' THEN price END),2) AS 'Sarria-Sant Gervasi',
ROUND(AVG(CASE WHEN district = 'Gracia' THEN price END),2) AS 'Gracia',
ROUND(AVG(CASE WHEN district = 'Horta-Guinardo' THEN price END),2) AS 'Horta-Guinardo',
ROUND(AVG(CASE WHEN district = 'Nou Barris' THEN price END),2) AS 'Nou Barris',
ROUND(AVG(CASE WHEN district = 'Sant Andreu' THEN price END),2) AS 'Sant Andreu',
ROUND(AVG(CASE WHEN district = 'Sant Marti' THEN price END),2) AS 'Sant Marti'
FROM barcelona_rent_working
WHERE average_rent = 'average rent per surface (euro/m2)'
GROUP BY year;

-- this query returns a pivot table of rent price per m2 by year for all districts
-- we can get a clear view of which districts are pricier and their development over the years

# MONTHLY PRICE BY DISTRICT

SELECT year,
ROUND(AVG(CASE WHEN district = 'Ciutat Vella' THEN price END),2) AS 'Ciutat Vella',
ROUND(AVG(CASE WHEN district = 'Eixample' THEN price END),2) AS 'Eixample',
ROUND(AVG(CASE WHEN district = 'Sants-Montjuic' THEN price END),2) AS 'Sants-Montjuic',
ROUND(AVG(CASE WHEN district = 'Les Corts' THEN price END),2) AS 'Les Corts',
ROUND(AVG(CASE WHEN district = 'Sarria-Sant Gervasi' THEN price END),2) AS 'Sarria-Sant Gervasi',
ROUND(AVG(CASE WHEN district = 'Gracia' THEN price END),2) AS 'Gracia',
ROUND(AVG(CASE WHEN district = 'Horta-Guinardo' THEN price END),2) AS 'Horta-Guinardo',
ROUND(AVG(CASE WHEN district = 'Nou Barris' THEN price END),2) AS 'Nou Barris',
ROUND(AVG(CASE WHEN district = 'Sant Andreu' THEN price END),2) AS 'Sant Andreu',
ROUND(AVG(CASE WHEN district = 'Sant Marti' THEN price END),2) AS 'Sant Marti'
FROM barcelona_rent_working
WHERE average_rent = 'average rent (euro/month)'
GROUP BY year;

-- similarly, this query returns a pivot table of monthly rent by year for all districts
-- again, visualize line charts for both sets of queries comparing price per square against price per month to determine districts with highest and lowest rent overall

