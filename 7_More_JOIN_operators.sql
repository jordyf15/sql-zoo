-- 1. List the films where the yr is 1962 [Show id, title] 
SELECT id, title
 FROM movie
 WHERE yr=1962;

-- 2. Give year of 'Citizen Kane'. 
SELECT yr 
FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). 
-- Order results by year. 
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4. What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca' 
SELECT id 
FROM movie
WHERE title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'. 
SELECT a.name
FROM actor AS a
INNER JOIN casting AS c ON a.id = c.actorid
INNER JOIN movie AS m ON c.movieid = m.id
WHERE m.id = 11768;

-- 7. Obtain the cast list for the film 'Alien' 
SELECT a.name
FROM actor AS a
INNER JOIN casting AS c ON a.id = c.actorid
INNER JOIN movie AS m ON c.movieid = m.id
WHERE m.title = 'Alien';

-- 8. List the films in which 'Harrison Ford' has appeared 
SELECT m.title
FROM movie AS m
INNER JOIN casting AS c ON m.id = c.movieid
INNER JOIN actor AS a ON c.actorid = a.id
WHERE a.name = 'Harrison Ford';

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. 
-- [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 
SELECT m.title
FROM movie AS m
INNER JOIN casting AS c ON m.id = c.movieid
INNER JOIN actor AS a ON c.actorid = a.id
WHERE a.name = 'Harrison Ford' AND c.ord != 1;

-- 10. List the films together with the leading star for all 1962 films. 
SELECT m.title, a.name
FROM movie AS m
INNER JOIN casting AS c ON m.id = c.movieid
INNER JOIN actor AS a ON c.actorid = a.id
WHERE c.ord = 1 AND m.yr = 1962;

-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
SELECT m.title, a.name
FROM movie AS m
INNER JOIN casting AS c ON c.movieid = m.id
INNER JOIN actor AS a ON a.id = c.actorid
WHERE c.movieid IN (
  SELECT movieid FROM casting
  WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews'))
AND c.ord = 1;
