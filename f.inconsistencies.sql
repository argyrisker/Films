Select person_id
From dbo.Person
GROUP BY person_id
HAVING COUNT(*) > 1

-- person_id = 47395
SELECT name, gender,job
FROM movie_crew
WHERE person_id = 47395

-- person_id = 47395
SELECT name, gender,character
FROM movie_cast
WHERE person_id = 47395

-- person_id = 47395
UPDATE movie_cast
SET gender = 2
WHERE person_id = 47395

-- person_id = 63574
SELECT name, gender
FROM movie_crew
WHERE person_id = 63574

-- person_id = 63574
SELECT name, gender
FROM movie_cast
WHERE person_id = 63574

-- person_id = 63574
UPDATE movie_crew
SET name='Cheung Ka-Fai'
WHERE person_id = 63574

-- person_id = 1785844
SELECT name, gender
FROM movie_crew
WHERE person_id = 1785844

-- person_id = 63574
SELECT name, gender
FROM movie_cast
WHERE person_id = 1785844

-- person_id = 1785844
UPDATE movie_crew
SET gender = 2
WHERE person_id = 1785844

-- person_id = 1785844
UPDATE movie_cast
SET gender = 2
WHERE person_id = 1785844