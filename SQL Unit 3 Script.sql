-- Question 1: Use Joins to list all customers who live in Texas
select first_name, last_name, address.district 
from customer
full join address
on customer.address_id = address.address_id
where district = 'Texas';


-- Question 2: Get all payments above $6.99 with the Customer's full name
select first_name, last_name, payment.amount 
from customer
full join payment
on customer.customer_id = payment.customer_id 
where amount >= 6.99;

-- Question 3: Use subqueries to show all customer names who have made payments over $175 
select first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	group by customer_id
	having sum(amount) > 175
	order by sum(amount)desc
);

-- Question 4: List all customers that live in Nepal. (Use city table)
select first_name, last_name, city.city 
from customer
full join address
on customer.address_id = address.address_id
full join city
on address.city_id = city.city_id 
where city.country_id = 66;


-- Question 5: Which staff member had the most transactions?
select staff_id, first_name, last_name 
from staff
where staff_id in(
	select staff_id
	from payment
	group by staff_id
	having count(payment_id) > 7300
);

-- Question 6: How many movies of each rating are there?
select count(rating), rating
from film
group by rating
order by count(rating) desc;

-- Question 7: Show all customers who have made a single payment above $6.99
select customer_id, first_name, last_name
from customer
where customer_id in (
	select rental_id
	from payment
	where amount > 6.99
	group by rental_id
	having count(distinct rental_id) < 2
)
group by customer_id;
	
-- Question 8: How many free rentals did our stores give away?
select count(rental.rental_id), payment.amount
from rental
full join payment
on rental.rental_id = payment.rental_id
where amount is null
group by payment.amount;


