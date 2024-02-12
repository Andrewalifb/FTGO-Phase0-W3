--Query 1 - Dapatkan data first_name dan last_name dari tabel actor dengan disortir descending.
SELECT first_name, last_name FROM actor
ORDER BY first_name DESC;

--Query 2 - Dapatkan data dari tabel actor dengan first_name didahului huruf C. Kemudian ambil 10 data teratas.
SELECT * FROM actor
WHERE UPPER(first_name) LIKE 'C%'; 

--Query 3 - Dapatkan data title, rental_rate dan rating dari tabel film, yang memiliki rating G atau R. 
-- Serta mempunyai rental_rate antara 2 sampai 5.
SELECT title, rental_rate, rating FROM film
WHERE (rating = 'G' OR rating = 'R') AND (rental_rate >= 2 AND rental_rate <= 5 ); 

--Query 4 - Dapatkan rating dan rata-rata nilai rental_duration dari tabel film. Kemudian kelompokkan berdasar rating.
SELECT rating, AVG(rental_duration) AS avg_duration
FROM film
GROUP BY rating;

--Query 4 - Dengan menggunakan INNER JOIN antara tabel film dan film_actor, tampilkan data title, actor_id dan film_id.
-- Kemudian lakukan filtering dimana actor_id adalah 15.
SELECT film.title, film_actor.actor_id ,film.film_id FROM film 
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id = 15;
