-- Частина 1: Запити на вибірку даних (SELECT)
-- Отримання списку фільмів та їх категорій: Напишіть SQL-запит, який виведе назву фільму, тривалість і категорію для кожного фільму.
select title,length,name as category
from film_category  
join film on film.film_id=film_category.film_id
join category  on category.category_id =film_category.category_id
-- Фільми, орендовані певним клієнтом: Напишіть запит, який виведе список фільмів, орендованих клієнтом з іменем "John Smith",
-- разом з датами оренди.
select title,rental_period
from inventory
join film on film.film_id=inventory.film_id 
join rental on rental.inventory_id =inventory.inventory_id 
join customer on customer.customer_id = rental.customer_id 
where customer.last_name ='SMITH'
order by rental_period asc 
-- Популярність фільмів: Напишіть запит, який виведе топ-5 найпопулярніших фільмів на основі кількості оренд.
select title,rental_duration 
from film
order by rental_duration desc
limit 5
-- Частина 2: Маніпуляції з даними (INSERT, UPDATE, DELETE)
-- Додавання нового клієнта: Додайте новий запис у таблицю клієнтів. 
-- Ім'я клієнта — "Alice Cooper", адреса — "123 Main St", місто — "San Francisco".
insert into city (city,country_id,last_update)
 values ('San Francisco',(select country_id from country where country='United States'),NOW());
insert into address (address,address2,district,city_id,postal_code,phone,last_update)
 values ('123 Main St','','District 1',(select city_id from city where city='San Francisco'),'1234','345-232',NOW());
insert into customer (store_id,first_name,last_name,email,address_id,activebool,create_date,last_update)
 values (1,'ALICE','COOPER','email@mail',(select address_id from address where address='123 Main St' limit 1),true,NOW(),NOW())
-- Оновлення адреси клієнта: Оновіть адресу клієнта "Alice Cooper" на "456 Elm St".
update address 
set address ='456 Elm St'
where address ='123 Main St'
-- Видалення клієнта: Видаліть запис про клієнта "Alice Cooper" з бази даних.
delete from customer 
where first_name ='ALICE' and last_name='COOPER';
delete  from  address 
where address='456 Elm St';
