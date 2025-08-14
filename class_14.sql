-- Exercise 1
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    a.address,
    ci.city
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
WHERE a.country_id = (
    SELECT country_id 
    FROM country 
    WHERE country = 'Argentina'
);

-- Exercise 2
SELECT 
    f.title,
    l.name AS language,
    CASE f.rating
        WHEN 'G' THEN 'General Audiences'
        WHEN 'PG' THEN 'Parental Guidance Suggested'
        WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
        WHEN 'R' THEN 'Restricted'
        WHEN 'NC-17' THEN 'Adults Only'
        ELSE 'Unknown'
    END AS full_rating
FROM film f
JOIN language l ON f.language_id = l.language_id;

-- Exercise 3
SET @actor_name = 'Tom Hanks';

SELECT f.title, f.release_year
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE LOWER(CONCAT(a.first_name, ' ', a.last_name)) LIKE LOWER(CONCAT('%', @actor_name, '%'));

-- Exercise 4
SELECT 
    f.title,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    CASE 
        WHEN r.return_date IS NULL THEN 'No'
        ELSE 'Yes'
    END AS returned
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id
WHERE MONTH(r.rental_date) IN (5,6);

-- Exercise 5
SELECT film_id, CAST(film_id AS CHAR) AS film_id_text FROM film LIMIT 5;
SELECT film_id, CONVERT(film_id, CHAR) AS film_id_text FROM film LIMIT 5;

-- Exercise 6
SELECT title, IFNULL(description, 'No description') AS description_text
FROM film LIMIT 5;
SELECT title, ISNULL(description) AS is_null_flag
FROM film LIMIT 5;
SELECT title, COALESCE(description, 'No description', 'Default') AS description_text
FROM film LIMIT 5;
