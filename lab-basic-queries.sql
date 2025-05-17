#1.Display all available tables in the Sakila database
show tables;

#Retrieve all the data from the tables actor, film and customer.
SELECT * FROM sakila.actor;

SELECT * FROM sakila.film;

SELECT * FROM sakila.customer;


#3. Retrieve the following columns from their respective tables:
#3.1 Titles of all films from the film table
#3.2 List of languages used in films, with the column aliased as language from the language table
#3.3 List of first names of all employees from the staff table

select 
	f.title,
    l.name as language,
    s.first_name
from film as f
join language as l
	on f.language_id = l.language_id
join inventory as i
	on f.film_id = i.film_id
join staff as s
	on i.store_id=s.store_id;
    
#4.Retrieve unique release years.

select 
	f.release_year,
	count(distinct f.release_year) as unique_release_years
from sakila.film as f
group by f.release_year;
    

#5Counting records for database insights:
	#5.1 Determine the number of stores that the company has.
	#5.2 Determine the number of employees that the company has.
	#5.3 Determine how many films are available for rent and how many have been rented.
	#5.4 Determine the number of distinct last names of the actors in the database.

select 
	s.store_id,
	count(distinct s.store_id)
from sakila.store as s
group by s.store_id;

select 
	s.staff_id,
	count(*) as staff_count
from sakila.staff as s
group by s.staff_id;

SELECT 
    f.film_id,
    f.title,
    COUNT(i.inventory_id) AS total_copies,
    SUM(CASE WHEN r.rental_id IS NOT NULL AND r.return_date IS NULL THEN 1 ELSE 0 END) AS rented_copies,
    COUNT(i.inventory_id) - SUM(CASE WHEN r.rental_id IS NOT NULL AND r.return_date IS NULL THEN 1 ELSE 0 END) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
GROUP BY f.film_id, f.title;

select 
	a.last_name,
    count(*) as actor_count
from sakila.actor as a
group by a.last_name;

#6.Retrieve the 10 longest films.

select
	f.length
from sakila.film as f
order by f.length desc
Limit 10;

#7.Retrieve all actors with the first name "SCARLETT".

select
	a.first_name
from sakila.actor as a
where a.first_name="Scarlett";





