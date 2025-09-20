USE sakila;

-- Queries with address table
SELECT * FROM address WHERE postal_code IN ('12345','67890');
SELECT a.*, c.city, co.country FROM address a 
JOIN city c ON a.city_id = c.city_id 
JOIN country co ON c.country_id = co.country_id 
WHERE a.postal_code NOT IN ('12345','67890');

CREATE INDEX idx_postal_code ON address(postal_code);

SELECT * FROM address WHERE postal_code IN ('12345','67890');
SELECT a.*, c.city, co.country FROM address a 
JOIN city c ON a.city_id = c.city_id 
JOIN country co ON c.country_id = co.country_id 
WHERE a.postal_code NOT IN ('12345','67890');

-- Queries with actor table
SELECT * FROM actor WHERE first_name = 'PENELOPE';
SELECT * FROM actor WHERE last_name = 'GUINESS';

-- Queries with film table using LIKE
SELECT * FROM film WHERE description LIKE '%love%';

-- Queries with film table using MATCH ... AGAINST
SELECT * FROM film WHERE MATCH(film_text) AGAINST('love' IN NATURAL LANGUAGE MODE);
