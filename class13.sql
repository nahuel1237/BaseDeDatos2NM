-- 1)
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
SELECT 1, 'Juan', 'Pérez', 'juan.perez@email.com', a.address_id, 1, NOW()
FROM address a
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country = 'United States'
ORDER BY a.address_id DESC
LIMIT 1;

-- 2)
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
SELECT NOW(), 
       (SELECT inventory_id FROM inventory ORDER BY inventory_id DESC LIMIT 1),
       (SELECT customer_id FROM customer ORDER BY RAND() LIMIT 1),
       (SELECT staff_id FROM staff WHERE store_id = 2 LIMIT 1);

-- 3)
UPDATE film SET release_year = 2001 WHERE rating = 'G';
UPDATE film SET release_year = 2002 WHERE rating = 'PG';
UPDATE film SET release_year = 2003 WHERE rating = 'PG-13';
UPDATE film SET release_year = 2004 WHERE rating = 'R';
UPDATE film SET release_year = 2005 WHERE rating = 'NC-17';

-- 4)
UPDATE rental
SET return_date = NOW()
WHERE rental_id = (
  SELECT rental_id
  FROM rental
  WHERE return_date IS NULL
  ORDER BY rental_date DESC
  LIMIT 1
);

-- 5)
DELETE FROM payment
WHERE rental_id IN (
  SELECT rental_id
  FROM rental
  WHERE inventory_id IN (
    SELECT inventory_id
    FROM inventory
    WHERE film_id = 1
  )
);

DELETE FROM rental
WHERE inventory_id IN (
  SELECT inventory_id
  FROM inventory
  WHERE film_id = 1
);

DELETE FROM inventory
WHERE film_id = 1;

DELETE FROM film_actor
WHERE film_id = 1;

DELETE FROM film_category
WHERE film_id = 1;

DELETE FROM film
WHERE film_id = 1;

-- 6)
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
  NOW(),
  42,
  (SELECT customer_id FROM customer ORDER BY RAND() LIMIT 1),
  (SELECT staff_id FROM inventory i
   JOIN store s ON i.store_id = s.store_id
   WHERE i.inventory_id = 42
   LIMIT 1)
);

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (
  (SELECT customer_id FROM rental WHERE inventory_id = 42 ORDER BY rental_id DESC LIMIT 1),
  (SELECT staff_id FROM rental WHERE inventory_id = 42 ORDER BY rental_id DESC LIMIT 1),
  (SELECT rental_id FROM rental WHERE inventory_id = 42 ORDER BY rental_id DESC LIMIT 1),
  5.99,
  NOW()
);
