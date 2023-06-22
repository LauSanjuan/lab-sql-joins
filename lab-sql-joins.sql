USE sakila;

-- 1. List the number of films per category.
SELECT category.name, COUNT(film_category.film_id) AS "Number of films" FROM sakila.film_category
JOIN sakila.category
ON film_category.category_id = category.category_id
GROUP BY category.category_id;

-- 2. Retrieve the store ID, city, and country for each store.
SELECT store.store_id, city.city, country.country FROM sakila.address
JOIN sakila.store 
ON address.address_id = store.address_id
JOIN sakila.city
ON address.city_id = city.city_id
JOIN sakila.country
ON city.country_id = country.country_id
GROUP BY store.store_id;

-- 3. Calculate the total revenue generated by each store in dollars.
SELECT store.store_id, SUM(payment.amount) AS 'total revenue' FROM sakila.staff
JOIN sakila.store 
ON staff.store_id = store.store_id
JOIN sakila.payment 
ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 4. Determine the average running time of films for each category.
SELECT category.name, AVG(film.length) AS 'average running time' FROM sakila.film_category
JOIN sakila.film
ON film_category.film_id = film.film_id
JOIN sakila.category
ON film_category.category_id = category.category_id
GROUP BY category.category_id;

-- 5. Identify the film categories with the longest average running time.
SELECT category.name, AVG(film.length) AS 'average running time' FROM sakila.film_category
JOIN sakila.film
ON film_category.film_id = film.film_id
JOIN sakila.category
ON film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY AVG(film.length) DESC
LIMIT 5;

-- 6. Display the top 10 most frequently rented movies in descending order.
SELECT film.film_id, film.title, COUNT(*) as "most frequently rented movies" from sakila.inventory
JOIN sakila.film
ON inventory.film_id =  film.film_id
JOIN sakila.rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id -- group by film_id because there could be two movies with the same title, but film_id is unique
ORDER BY COUNT(*) DESC
LIMIT 10;

-- 7. Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT COUNT(*) AS "Number of copies in store 1" FROM sakila.inventory
JOIN sakila.store
ON inventory.store_id = store.store_id
JOIN sakila.film
ON inventory.film_id = film.film_id
WHERE film.title = 'Academy Dinosaur' AND store.store_id = 1;

