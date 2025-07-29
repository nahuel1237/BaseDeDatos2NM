-- 1)
CREATE OR REPLACE VIEW list_of_customers AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    a.address,
    a.postal_code AS zip_code,
    a.phone,
    ci.city,
    co.country,
    CASE 
        WHEN c.active = 1 THEN 'active'
        ELSE 'inactive'
    END AS status,
    c.store_id
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 2)
CREATE OR REPLACE VIEW film_details AS
SELECT 
    f.film_id,
    f.title,
    f.description,
    c.name AS category,
    f.rental_rate AS price,
    f.length,
    f.rating,
    GROUP_CONCAT(CONCAT(a.first_name, ' ', a.last_name) SEPARATOR ', ') AS actors
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY f.film_id;

-- 3)
CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT 
    c.name AS category,
    COUNT(r.rental_id) AS total_rental
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 4)
CREATE OR REPLACE VIEW actor_information AS
SELECT 
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS total_films
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;


/*
5) Análisis de la vista actor_info (base de datos sakila)

La vista `actor_info` muestra información de cada actor junto con todas las películas en las que actuó y sus respectivas categorías. Esta vista se crea con varios JOIN para unir las tablas relacionadas y usa una función de agregación para mostrar todo en una sola línea por actor.

Query típica de creación:

CREATE VIEW actor_info AS
SELECT
  a.actor_id,
  a.first_name,
  a.last_name,
  GROUP_CONCAT(DISTINCT CONCAT(f.title, ' (', c.name, ')') SEPARATOR ', ') AS film_info
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY a.actor_id, a.first_name, a.last_name;

Desglose de partes clave:
- a.actor_id, a.first_name, a.last_name: Muestra los datos básicos del actor.
- JOINs: Conectan actores con películas (film_actor), y estas con sus categorías (film_category + category).
- GROUP_CONCAT(...): Junta todas las películas con su categoría en un solo campo tipo "Pulp Fiction (Drama), Kill Bill (Action)".
- GROUP BY: Agrupa los resultados para que haya solo una fila por actor.

No hay subconsultas explícitas, pero el uso de GROUP_CONCAT con DISTINCT cumple un rol similar a una subconsulta agregada.


6) Materialized Views (Vistas Materializadas)

Una materialized view es como una vista normal, pero guarda físicamente los datos en disco, lo que hace que las consultas sobre ella sean mucho más rápidas.

Características principales:
- Los datos ya vienen precalculados y almacenados.
- Se pueden actualizar manualmente o con programación automática.
- Muy útiles para reportes o dashboards que no necesitan información en tiempo real.

Ventajas:
- Aumentan el rendimiento de consultas complejas.
- Evitan recalcular siempre los mismos datos (joins, agregaciones, etc.).

Alternativas a una materialized view:
- Vistas normales (más lentas).
- Tablas temporales.
- Caché en el backend de la aplicación.

Soporte según sistema de base de datos:
- Oracle: Soporte completo, incluso con refresco automático.
- PostgreSQL: Soporte nativo, pero el refresco debe hacerse manualmente.
- SQL Server: Usa “indexed views”, que cumplen una función parecida.
- MySQL: No las soporta directamente, pero se pueden emular con triggers, eventos o jobs.

Resumen:
Las vistas materializadas son ideales para acelerar consultas, especialmente cuando se trabaja con grandes volúmenes de datos o informes, aunque puede haber una leve desactualización de los datos según cómo se refresquen.
*/
