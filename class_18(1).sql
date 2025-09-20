DELIMITER $$

CREATE FUNCTION copies_in_store(p_film_id INT, p_film_name VARCHAR(255), p_store_id INT) RETURNS INT
BEGIN
    DECLARE copies INT;
    IF p_film_id IS NOT NULL THEN
        SELECT COUNT(*) INTO copies
        FROM inventory
        WHERE film_id = p_film_id AND store_id = p_store_id;
    ELSE
        SELECT COUNT(*) INTO copies
        FROM inventory i
        JOIN film f ON i.film_id = f.film_id
        WHERE f.title = p_film_name AND i.store_id = p_store_id;
    END IF;
    RETURN copies;
END$$

CREATE PROCEDURE customers_by_country(IN p_country VARCHAR(50), OUT p_names TEXT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE first_name VARCHAR(50);
    DECLARE last_name VARCHAR(50);
    DECLARE cur CURSOR FOR
        SELECT first_name, last_name FROM customer c
        JOIN address a ON c.address_id = a.address_id
        JOIN city ci ON a.city_id = ci.city_id
        JOIN country co ON ci.country_id = co.country_id
        WHERE co.country = p_country;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET p_names = '';

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO first_name, last_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        IF p_names != '' THEN
            SET p_names = CONCAT(p_names, ';', first_name, ' ', last_name);
        ELSE
            SET p_names = CONCAT(first_name, ' ', last_name);
        END IF;
    END LOOP;
    CLOSE cur;
END$$

DELIMITER ;