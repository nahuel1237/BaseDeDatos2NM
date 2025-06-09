use sakila;

-- 1
SELECT country, country_id,
       (SELECT COUNT(*) FROM city WHERE city.country_id = c.country_id) AS total_cities
FROM country c
ORDER BY country, country_id;

-- 2
SELECT country, country_id,
       (SELECT COUNT(*) FROM city WHERE city.country_id = c.country_id) AS total_cities
FROM country c
WHERE (SELECT COUNT(*) FROM city WHERE city.country_id = c.country_id) > 10
ORDER BY total_cities DESC;

-- 3
SELECT c.first_name, c.last_name,
       (SELECT address FROM address WHERE address_id = c.address_id) AS address,
       (SELECT COUNT(*) FROM rental r WHERE r.customer_id = c.customer_id) AS total_rentals,
       (SELECT SUM(p.amount)
        FROM payment p
        JOIN rental r ON p.rental_id = r.rental_id
        WHERE r.customer_id = c.customer_id) AS total_spent
FROM customer c
ORDER BY total_spent DESC;

-- 4
SELECT DISTINCT name,
       (SELECT AVG(length)
        FROM film f
        JOIN film_category fc ON f.film_id = fc.film_id
        WHERE fc.category_id = c.category_id) AS avg_duration
FROM category c
ORDER BY avg_duration DESC;


-- 5
SELECT DISTINCT f.rating,
       (SELECT SUM(p.amount)
        FROM film f2
        JOIN inventory i2 ON f2.film_id = i2.film_id
        JOIN rental r2 ON i2.inventory_id = r2.inventory_id
        JOIN payment p ON r2.rental_id = p.rental_id
        WHERE f2.rating = f.rating) AS total_sales
FROM film f
ORDER BY total_sales DESC;

