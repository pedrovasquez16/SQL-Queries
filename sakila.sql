-- 1a. Display first and last name of all actors from table ACTORS

SELECT first_name, last_name 
FROM sakila.actor; 


-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name

SELECT *, CONCAT(first_name, " ", last_name) AS Actor_Name 
FROM sakila.actor;


-- 2a. Find the ID number, first name, and last name of an actor whose name begins with 'Joe'

SELECT actor_id, first_name, last_name 
FROM sakila.actor 
WHERE first_name = "Joe";

-- 2b. Find all actors whose last name contain the letters 'GEN'

SELECT first_name, last_name
FROM sakila.actor
WHERE last_name LIKE "%G%" OR "%E%" OR "%N%"; 

-- 2c. Find all actors whose last names contain the leters 'LI'. Order rows by last name then first name


SELECT first_name, last_name
FROM sakila.actor
WHERE last_name LIKE "%L%" OR "%I%"
ORDER BY last_name ASC, first_name DESC;


-- 2d. Using IN, display country_ID and country columns for Afghanistan, Bangladesh, and China

SELECT country_ID, country
FROM sakila.country
WHERE country IN ("Afghanistan", "Bangladesh", "China") 


-- 3a. Appened a 'Description' column into 'Actor' table

ALTER TABLE sakila.actor
ADD Description BLOB;

-- 3b. Delete 'Description' column 

ALTER TABLE sakila.actor
DROP COLUMN Description;

-- 4a. List the last names of actors, and the number of actors that have that last name

SELECT COUNT(last_name), last_name
FROM sakila.actor
GROUP BY last_name; 

-- 4b. List last names and the number of actors who have the same last name, but only for names that are shared by at least two actors

SELECT COUNT(last_name), last_name
FROM sakila.actor
GROUP BY last_name 
HAVING COUNT(last_name) > 1;

-- 4c. Fix the record 'Harpo Williams' to 'Groucho Williams'

UPDATE sakila.actor
SET first_name = "Groucho"
WHERE first_name = "Harpo" AND last_name ="Williams"; 


-- 4d. Change first name back to 'Harpo' from 'Groucho'

UPDATE sakila.actor
SET first_name = "HARPO"
WHERE first_name = "Groucho" AND last_name = "Williams"; 


-- 5a. Recreate the schema of the 'adress' table




-- 6a. Use JOIN to display first name, last name, address, staff member from 'staff' and 'address' tables

SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON staff.address_ID = address.address_ID; 


-- 6b. Use JOIN to display total amount rung up by each staff member in August of 2005. Use tables 'staff' and 'payment'

SELECT staff.first_name, SUM(payment.amount) 
FROM payment
INNER JOIN staff ON payment.staff_id = staff.staff_id
WHERE payment_date LIKE "2005-08%"
GROUP BY first_name;


-- 6.C List each film and the number of actors who are listed for that film. Use INNER JOIN on 'film_actor' and 'film' tables

SELECT film.title, COUNT(actor_id) AS Number_of_Actors
FROM film_actor
INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY film_actor.actor_id;


-- 6.d How many copies of the film Hunchback 'Impossible' exist in the inventory system?

SELECT film_ID, COUNT(inventory_ID) AS Number_of_Copies
FROM inventory
WHERE film_ID = 439;


-- 6e. List total paid by each customer alphabetically by last name. JOIN 'payment' and 'customer' tables

SELECT customer.last_name, customer.first_name, SUM(payment.amount) AS "Customer Payment"
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY customer.last_name DESC; 


-- 7a. Display titles of movies 1) starting with letters 'K' and 'Q' and 2) whose language is English 

SELECT * 
FROM FILM 
WHERE title LIKE "K%" OR title LIKE "Q%" AND language_id IN 
(
	SELECT language_id 
    FROM LANGUAGE
    WHERE name = "English"
);


-- 7b. Subquery to display all actors who appear in the fim 'Alone Trip'

SELECT first_name, last_name
FROM actor
WHERE actor_id IN 

(	SELECT actor_id
    FROM FILM_ACTOR
    WHERE film_id IN
    
(	SELECT film_id
	FROM FILM
	WHERE title = "Alone Trip"));


-- 7c. Get names and emails of all Canadians. Use JOINS

SELECT last_name, first_name, email
FROM CUSTOMER
WHERE address_id IN 

(	SELECT address_id
	FROM ADDRESS
    WHERE city_id IN

(	SELECT city_id
    FROM CITY
    WHERE country_id IN 

(	SELECT country_id
	FROM COUNTRY
    WHERE country = "Canada")));


-- 7d. Identify all movies categorized as family films

SELECT film.title, category.name
FROM ((FILM_CATEGORY
INNER JOIN FILM ON film_category.film_id = film.film_id)
INNER JOIN CATEGORY ON film_category.category_id = category.category_id)
WHERE category.name = "Family";

-- 7e. Display most frequent rented movies in descending order

SELECT film.title, COUNT(rental.inventory_id) AS Rental_Frequency
FROM ((inventory
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id)
INNER JOIN film ON inventory.film_id = film.film_id)
GROUP BY inventory.film_id
ORDER BY rental_frequency DESC;


-- 7f. Display how much business in dollars each store brought in 

SELECT customer.store_id, SUM(payment.amount) AS "Total Revenue"
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store_id;

-- 7g. Display each store it's store ID, city, and country

SELECT address.address_id, address.address, city.city, country.country
FROM ((CITY 
INNER JOIN ADDRESS ON city.city_id = address.city_id)
INNER JOIN COUNTRY ON city.country_id = country.country_id)
WHERE address_id = 1 or address_id = 2 ;

-- 7h. Top 5 genres in gross revenue in DESC.

SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film_category;
SELECT * FROM category;

SELECT film_id, amount
FROM ((RENTAL
INNER JOIN PAYMENT ON RENTAL.rental_id = PAYMENT.rental_id
INNER JOIN INVENTORY ON RENTAL.inventory_id = INVENTORY.inventory_id
INNER JOIN (
	SELECT film_id
    FROM FILM_CATEGORY
    INNER JOIN CATEGORY ON FILM_CATEGORY.category_id = CATEGORY.category_id
    GROUP BY name
)));















