-- *Загальна кількість фільмів у кожній категорії: Напишіть SQL-запит, який виведе назву категорії та кількість фільмів у кожній категорії.
select name as category, count(*) as amount
from film 
join film_category on film_category.film_id  = film.film_id 
join category on category.category_id = film_category.category_id 
group by name
-- *Середня тривалість фільмів у кожній категорії: Напишіть запит, який виведе назву категорії та середню тривалість фільмів у цій категорії.
select name as category,round(avg(length)) as average_duration
from film 
join film_category on film_category.film_id  = film.film_id 
join category on category.category_id = film_category.category_id 
group by name
-- *Мінімальна та максимальна тривалість фільмів: Напишіть запит, який виведе мінімальну та максимальну тривалість фільмів у базі даних.
select max(length) as max_duration,min(length) as min_duration
from film 
-- *Загальна кількість клієнтів: Напишіть запит, який поверне загальну кількість клієнтів у базі даних.
select count(*) as amount_of_customers 
from customer 
-- *Сума платежів по кожному клієнту: Напишіть запит, який виведе ім'я клієнта та загальну суму платежів, яку він здійснив.
select CONCAT(first_name, ' ', last_name) AS full_name , sum(amount) as total_payment_summ
from customer 
join payment on payment.customer_id =customer.customer_id 
group by full_name
-- *П'ять клієнтів з найбільшою сумою платежів: Напишіть запит, який виведе п'ять клієнтів, які здійснили найбільшу кількість платежів, у порядку спадання.
select  CONCAT(first_name, ' ',last_name) AS full_name ,sum(amount) as total_payment_summ
from customer 
join payment on payment.customer_id =customer.customer_id 
group by full_name
order by total_payment_summ desc
limit 5
-- *Загальна кількість орендованих фільмів кожним клієнтом: Напишіть запит, який поверне ім'я клієнта та кількість фільмів, які він орендував.
select CONCAT(first_name, ' ', last_name) AS full_name , count(*) as rent_amount
from customer 
join rental on rental.customer_id =customer.customer_id 
group by full_name
-- *Середній вік фільмів у базі даних: Напишіть запит, який виведе середній вік фільмів (різниця між поточною датою та роком випуску фільму).
select avg(extract(year from now()) - release_year) as average_movie_age
from film
-- *Кількість фільмів, орендованих за певний період: Напишіть запит, який виведе кількість фільмів, орендованих у період між двома вказаними датами.
select count(*) as all_rented_movies_in_period 
from rental 
-- !                                  any date                                      any date
where lower(rental_period)::date >= '2005-01-01' and upper(rental_period)::date <='2010-01-01' 
-- *Сума платежів по кожному місяцю: Напишіть запит, який виведе загальну суму платежів, здійснених кожного місяця.
select extract(month from payment_date) as months, sum(amount) as whole_payments_amount
from payment
group by months
order by months asc
-- *Максимальна сума платежу, здійснена клієнтом: Напишіть запит, який виведе максимальну суму окремого платежу для кожного клієнта.
select CONCAT(first_name, ' ', last_name) AS full_name, max(amount) as max_payment
from payment
join customer on customer.customer_id = payment.customer_id 
group by full_name
order by max_payment desc
-- *Середня сума платежів для кожного клієнта: Напишіть запит, який виведе ім'я клієнта та середню суму його платежів.
select CONCAT(first_name, ' ', last_name) AS full_name,round( avg(amount),2) as average_payment
from payment
join customer on customer.customer_id = payment.customer_id 
group by full_name
order by average_payment desc
-- *Кількість фільмів у кожному рейтингу (rating): Напишіть запит, який поверне кількість фільмів для кожного з можливих рейтингів (G, PG, PG-13, R, NC-17).
select rating, count(*) as amount
from film
group by rating 
order by rating asc
-- *Середня сума платежів по кожному магазину (store): Напишіть запит, який виведе середню суму платежів, здійснених у кожному магазині.
select address as store,round(avg(amount),2) as average_payment
from store
join address on address.address_id =store.address_id 
join customer on customer.store_id =store.store_id 
join payment on payment.customer_id =customer.customer_id 
group by address
