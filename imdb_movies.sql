-- Let's take a look at the highest grossing genre
SELECT
	Genre, 
	SUM(Gross) AS Total_Gross
FROM imdb_top_1000
GROUP BY Genre
ORDER BY Total_GROSS DESC
-- The query above does return a numerical descending list since it is a text column type. Let's replace empty cells with 0, remove the commas, and then change the column type. 
UPDATE imdb_top_1000
SET Gross = ifnull(Gross,0);
-- Saw that blanks cells didn't populate with zeros. This means we have to use NULLIF and IFNULL functions to convert empty strings to 0
UPDATE imdb_top_1000
SET Gross = IFNULL(NULLIF(Gross, ''),0);
-- Remove the commas
UPDATE imdb_top_1000
SET Gross = REPLACE(Gross, ',','');
-- Let's take a look.
Select Gross
FROM imdb_top_1000-- As you can see, the commas are gone and the blanks are filled with 0. We can perform these two actions in one query. For the sake of the exercsie, we had to break it down into two.
-- Now we can change the column type with a few clicks. Click on Database Structure -> Click on the table -> Edit -> Modify Table -> Scroll down to Gross and change text field to integer field
-- Let's take a look at the highest grossing genre again
SELECT
	Genre, 
	SUM(Gross) AS Total_Gross
FROM imdb_top_1000
GROUP BY Genre
ORDER BY Total_GROSS DESC

-- We are going to perform more analysis now. 
-- Highest Grossing Movies of all time with their ratings and meta score
SELECT 
	Series_Title,
	Gross,
	IMDB_Rating,
	Meta_score
FROM imdb_top_1000
ORDER by Gross DESC
Limit 10;

-- Which actors has a high average rating
SELECT 
	Star1, 
	ROUND(AVG(IMDB_Rating),1) AS avg_rating
FROM imdb_top_1000GROUP BY Star1
ORDER BY avg_rating DESC


-- Count of Genres
SELECT
	Genre,
	COUNT(*) as genre_count
FROM imdb_top_1000
GROUP BY Genre
ORDER by genre_count DESC;

-- Director's gross
SELECT
	Director,
	COUNT(*) AS Movie_Count,
	SUM(Gross) AS Total_Gross,
	MAX(GROSS) AS max_Gross,
	ROUND(AVG(Gross),2) AS avg_Gross
FROM imdb_top_1000
GROUP BY Director
ORDER BY Total_Gross DESC;

-- Movie count of Star1
SELECT
	Star1,
	COUNT(*) AS MovieCount
FROM imdb_top_1000
WHERE Star1 IS NOT NULL
GROUP BY Star1
ORDER BY MovieCount DESC;

-- Which actor prefer which Genre more?
SELECT Star1, Genre, COUNT(*) AS MovieCount
FROM imdb_top_1000
WHERE Star1 IS NOT NULL
	AND Genre IS NOT NULL
GROUP BY Star1
ORDER BY MovieCount DESC;

-- Which combination of actors are getting good IMDB_Rating maximum time?
SELECT Star1, Star2, Star3, Star4, AVG(IMDB_Rating) AS AvgRating, COUNT(*) AS MovieCount
FROM imdb_top_1000
WHERE Star1 IS NOT NULL
   AND Star2 IS NOT NULL
   AND Star3 IS NOT NULL
   AND Star4 IS NOT NULL
GROUP BY Star1, Star2, Star3, Star4
HAVING COUNT(*) >= 1
ORDER BY AvgRating DESC, MovieCount DESC;

-- Which combination of actors are getting good gross?
SELECT 
	Star1, 
	Star2, 
	Star3, 
	Star4, 
	SUM(Gross) AS Total_Gross
FROM imdb_top_1000
WHERE Star1 IS NOT NULL
   AND Star2 IS NOT NULL
   AND Star3 IS NOT NULL
   AND Star4 IS NOT NULL
GROUP BY Star1, Star2, Star3, Star4
ORDER BY Total_Gross DESC;