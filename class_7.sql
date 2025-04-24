use sakila;
-- 1
SELECT title, rating
FROM film
WHERE length = (SELECT MIN(length) FROM film);

-- 2
SELECT title
FROM film
WHERE length = (SELECT MIN(length) FROM film)
AND (SELECT COUNT(*) FROM film WHERE length = (SELECT MIN(length) FROM film)) = 1;

-- 3
SELECT c.customer_id, c.first_name, c.last_name, a.address, MIN(p.amount) AS lowest_payment
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.address;

SELECT DISTINCT c.customer_id, c.first_name, c.last_name, a.address, p.amount AS lowest_payment
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN payment p ON c.customer_id = p.customer_id
WHERE p.amount <= ALL (
    SELECT p2.amount
    FROM payment p2
    WHERE p2.customer_id = c.customer_id
);


-- 4
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    (SELECT MAX(p.amount) FROM payment p WHERE p.customer_id = c.customer_id) AS highest_payment,
    (SELECT MIN(p.amount) FROM payment p WHERE p.customer_id = c.customer_id) AS lowest_payment
FROM customer c;
