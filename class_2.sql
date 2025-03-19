DROP DATABASE IF EXISTS imdb;
CREATE DATABASE imdb;
USE imdb;
CREATE TABLE film(
	film_id INT auto_increment,
    title VARCHAR(20),
    descripcion VARCHAR(100),
    relase_year DATE,
    CONSTRAINT PK_FILM PRIMARY KEY (film_id)
    );
CREATE TABLE actor(
	actor_id INT auto_increment,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    CONSTRAINT PK_ACTOR PRIMARY KEY (actor_id)
    );
CREATE TABLE film_actor(
	actor_id INT,
    film_id INT 
    );
ALTER TABLE actor
ADD CONSTRAINT FK_ACTOR FOREIGN KEY (actor) REFERENCES actor(actor_id),
ADD CONSTRAINT FK_ACTOR2 FOREIGN KEY (film) REFERENCES film(film_id);

ALTER TABLE film ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE actor ADD COLUMN last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
INSERT INTO actor (first_name, last_name) VALUES
('Robert', 'Downey Jr.'),
('Chris', 'Evans'),
('Scarlett', 'Johansson');

INSERT INTO film (title, description, release_year) VALUES
('Avengers: Endgame', 'The Avengers face the ultimate challenge.', 2019),
('Iron Man', 'Tony Stark becomes the armored superhero Iron Man.', 2008),
('Captain America: The First Avenger', 'Steve Rogers becomes Captain America to fight Hydra.', 2011);
