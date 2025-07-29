-- 1)
SELECT title
FROM film
WHERE film_id NOT IN (
    SELECT DISTINCT film_id
    FROM inventory
);

-- 2)
SELECT f.title, i.inventory_id
FROM inventory i
JOIN film f ON i.film_id = f.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

-- 3)
SELECT cu.first_name, cu.last_name, cu.store_id, f.title,
       r.rental_date, r.return_date
FROM customer cu
JOIN rental r ON cu.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
ORDER BY cu.store_id, cu.last_name;

-- 4)
SELECT CONCAT(ci.city, ', ', co.country) AS location,
       CONCAT(stf.first_name, ' ', stf.last_name) AS manager,
       SUM(p.amount) AS total_sales
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN staff stf ON s.manager_staff_id = stf.staff_id
JOIN customer cu ON s.store_id = cu.store_id
JOIN payment p ON cu.customer_id = p.customer_id
GROUP BY s.store_id, location, manager;

-- 5)
SELECT a.first_name, a.last_name, COUNT(*) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1;
