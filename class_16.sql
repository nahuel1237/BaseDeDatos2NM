-- 1
INSERT INTO employees(employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (1100,'Lopez','Carlos','x1234',NULL,'1',1002,'Engineer');

-- 2
UPDATE employees SET employeeNumber = employeeNumber - 20;
UPDATE employees SET employeeNumber = employeeNumber + 20;

-- 3
ALTER TABLE employees
ADD age INT NOT NULL CHECK (age BETWEEN 16 AND 70);

-- 4

-- 5
ALTER TABLE employees
ADD lastUpdate DATETIME DEFAULT CURRENT_TIMESTAMP,
ADD lastUpdateUser VARCHAR(50);

DELIMITER $$
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = USER();
END$$

CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW();
    SET NEW.lastUpdateUser = USER();
END$$
DELIMITER ;

-- 6
SELECT TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE, ACTION_STATEMENT
FROM INFORMATION_SCHEMA.TRIGGERS
WHERE TRIGGER_SCHEMA = 'sakila' AND EVENT_OBJECT_TABLE = 'film_text';
