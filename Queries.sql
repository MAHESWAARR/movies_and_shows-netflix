use Nani_titles;

-- What were the top 10 movies according to IMDB score?

select nani_titles.title
from nani_titles
WHERE imdb_score >= 8.0
AND type = 'MOVIE'
ORDER BY imdb_score DESC
LIMIT 10;


-- What were the top 10 shows according to IMDB score?

select nani_titles.title
from nani_titles
WHERE imdb_score >= 8.0
AND type = 'SHOW'
ORDER BY imdb_score DESC
LIMIT 10; 

-- What were the bottom 10 movies according to IMDB score? 

select nani_titles.title
from nani_titles
WHERE imdb_score >= 8.0
AND type = 'MOVIE'
ORDER BY imdb_score
LIMIT 10;


-- What were the bottom 10 shows according to IMDB score? 

select nani_titles.title
from nani_titles
WHERE imdb_score >= 8.0
AND type = 'show'
ORDER BY imdb_score 
LIMIT 10;


-- What were the average IMDB and TMDB scores for shows and movies? 
SELECT DISTINCT type, 
ROUND(AVG(imdb_score),2) AS avg_imdb_score,
ROUND(AVG(tmdb_score),2) as avg_tmdb_score
FROM nani_titles
GROUP BY type; 


-- Count of movies and shows in each decade
SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade,
	COUNT(*) AS movies_shows_count
FROM nani_titles
WHERE release_year >= 1940
GROUP BY CONCAT(FLOOR(release_year / 10) * 10, 's')
ORDER BY decade;


-- What were the 5 most common age certifications for movies?
SELECT age_certification, 
COUNT(*) AS certification_count
FROM nani_titles
WHERE type = 'Movie' 
AND age_certification != 'N/A'
GROUP BY age_certification
ORDER BY certification_count DESC
LIMIT 5;



-- Who were the top 20 actors that appeared the most in movies/shows? 
SELECT DISTINCT name as actor, 
COUNT(*) AS number_of_appearences 
FROM credits
WHERE role = 'actor'
GROUP BY name
ORDER BY number_of_appearences DESC
LIMIT 20;

-- Who were the top 20 directors that directed the most movies/shows? 
SELECT DISTINCT name as director, 
COUNT(*) AS number_of_appearences 
FROM credits
WHERE role = 'director'
GROUP BY name
ORDER BY number_of_appearences DESC
LIMIT 20;


-- Calculating the average runtime of movies and TV shows separately
SELECT 
'Movies' AS content_type,
ROUND(AVG(runtime),2) AS avg_runtime_min
FROM nani_titles
WHERE type = 'Movie'
UNION ALL
SELECT 
'Show' AS content_type,
ROUND(AVG(runtime),2) AS avg_runtime_min
FROM nani_titles
WHERE type = 'Show';

-- Finding the titles and  directors of movies released on or after 2010
SELECT DISTINCT t.title, c.name AS director, 
t.release_year
FROM nani_titles AS t
JOIN credits AS c 
ON t.id = c.id
WHERE t.type = 'Movie' 
AND t.release_year >= 2010 
AND c.role = 'DIRECTOR'
ORDER BY release_year DESC;


-- Titles and Directors of movies with high IMDB scores (>7.5) and high TMDB popularity scores (>80) 
SELECT t.title, 
c.name AS director
FROM nani_titles AS t
JOIN credits AS c 
ON t.id = c.id
WHERE t.type = 'Movie' 
AND t.imdb_score > 2.5 
AND t.tmdb_popularity > 80 
AND c.role = 'director';


-- Which shows on Netflix have the most seasons?
SELECT title, 
SUM(seasons) AS total_seasons
FROM nani_titles 
WHERE type = 'Show'
GROUP BY title
ORDER BY total_seasons DESC
LIMIT 10;


-- What were the total number of titles for each year? 
SELECT release_year, 
COUNT(*) AS title_count
FROM nani_titles 
WHERE release_year = 2010 OR release_year > 1900
GROUP BY release_year
ORDER BY release_year DESC;


-- SELECT '2010' AS year_group,
-- FROM nani_titles 
-- WHERE release_year = 2010
-- UNION ALL
-- SELECT '>1900' AS year_group,
-- FROM nani_titles
-- WHERE release_year > 1900
-- ORDER BY year_group;

-- What were the top 3 most common genres after 2010?
SELECT t.genres, 
COUNT(*) AS genre_count
FROM nani_titles AS t
WHERE t.type = 'Movie' and release_year >2010
GROUP BY t.genres
ORDER BY genre_count DESC
LIMIT 3;



-- country based production_countries along with release_year
select production_countries,release_year,
COUNT(*) AS production_countries_count
from nani_titles 
where production_countries LIKE '%US%' 
group by production_countries,release_year
order by production_countries_count desc;
-- limit 10;

-- to know from which zone the movie and show is from
select genres,
COUNT(*) as comedy_count
from nani_titles
where genres like '%comedy%' and genres like '%romance%'
group by genres;




-- sept1123
-- MIN AND MAX RUNTIME OF MOVIE AND SHOW
select
MIN(runtime) AS min_runtime,
MAX(runtime) AS max_runtime
FROM nani_titles
WHERE runtime > 0 AND runtime <300;

SELECT SUM(runtime),
(AVG(runtime)/2)  AS avg_runtime
FROM nani_titles;











