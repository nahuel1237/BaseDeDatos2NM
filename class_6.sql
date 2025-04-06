use sakila;
-- 1
select last_name from actor
order by last_name ASC;

-- 2
select a.first_name from actor a
left join film_actor fa on a.actor_id = fa.actor_id
where fa.actor_id is null;

-- 3
select c.first_name, r.rental_id from customer c
inner join rental r on c.customer_id = r.customer_id
group by r.rental_id, c.first_name
having count(distinct r.rental_id) = 1;

-- 4
select c.first_name, r.rental_id from customer c
inner join rental r on c.customer_id = r.customer_id
group by r.rental_id, c.first_name
having count(distinct r.rental_id) >1;

-- 5
select a.first_name, f.title from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on fa.film_id = f.film_id
where f.title in('BETRAYED REAR' , 'CATCH AMISTAD');

-- 6
select a.first_name, f.title from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on fa.film_id = f.film_id
where f.title = 'BETRAYED REAR' AND
f.title not in (
select fa2.actor_id
from film_actor fa2
join film f2 on fa2.film_id = f2.film_id
where f2.title = 'CATCH AMISTAD');

-- 7
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title IN ('BETRAYED REAR', 'CATCH AMISTAD')
GROUP BY a.first_name, a.last_name
HAVING COUNT(DISTINCT f.title) = 2;

-- 8
SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title IN ('BETRAYED REAR', 'CATCH AMISTAD')
);
