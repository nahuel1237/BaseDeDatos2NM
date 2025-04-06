	-- clase 2

DROP DATABASE IF EXISTS imdb;
CREATE DATABASE IF NOT EXISTS imdb;
USE imdb;

CREATE TABLE film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_year YEAR NOT NULL
);

CREATE TABLE actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

CREATE TABLE film_actor (
    actor_id INT,
    film_id INT,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (film_id) REFERENCES film(film_id) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE film ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE actor ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


INSERT INTO film (title, description, release_year) VALUES
('Inception', 'A mind-bending thriller about dreams within dreams.', 2010),
('The Matrix', 'A hacker discovers the true nature of reality.', 1999),
('Interstellar', 'A journey through space and time.', 2014);


INSERT INTO actor (first_name, last_name) VALUES
('Leonardo', 'DiCaprio'),
('Keanu', 'Reeves'),
('Matthew', 'McConaughey');


INSERT INTO film_actor (actor_id, film_id) VALUES
(1, 1), -- Leonardo DiCaprio en Inception
(2, 2), -- Keanu Reeves en The Matrix
(3, 3); -- Matthew McConaughey en Interstellar


SELECT * FROM film;
SELECT * FROM actor;
SELECT * FROM film_actor;

-- clase 4 
-- 1 

	SELECT title, special_features  
	FROM film  
	WHERE rating = 'PG-13';
    
-- 2

	SELECT  length  
	FROM film;

-- 3 

	SELECT title, rental_rate, replacement_cost  
	FROM film  
	WHERE replacement_cost BETWEEN 20.00 AND 24.00;

-- 4 

SELECT f.title, c.name AS category, f.rating  
FROM film f  
JOIN film_category fc ON f.film_id = fc.film_id  
JOIN category c ON fc.category_id = c.category_id  
WHERE FIND_IN_SET('Behind the Scenes', f.special_features) > 0;

-- 5 

	SELECT a.first_name, a.last_name  
	FROM actor a  
	JOIN film_actor fa ON a.actor_id = fa.actor_id  
	JOIN film f ON fa.film_id = f.film_id  
	WHERE f.title = 'ZOOLANDER FICTION';

-- 6 
 
	SELECT a.address, ci.city, co.country  
	FROM store s  
	JOIN address a ON s.address_id = a.address_id  
	JOIN city ci ON a.city_id = ci.city_id  
	JOIN country co ON ci.country_id = co.country_id  
	WHERE s.store_id = 1;
-- 7

	SELECT f1.title AS film1, f2.title AS film2, f1.rating
	FROM films f1
	JOIN films f2 
	ON f1.rating = f2.rating 
	AND f1.title < f2.title
	ORDER BY f1.rating;
    
-- 8
	SELECT f.title AS pelicula, s.first_name AS gerente_nombre, s.last_name AS gerente_apellido
	FROM film f
	JOIN inventory i ON f.film_id = i.film_id
	JOIN store st ON i.store_id = st.store_id
	JOIN staff s ON st.manager_staff_id = s.staff_id
	WHERE i.store_id = 2;


