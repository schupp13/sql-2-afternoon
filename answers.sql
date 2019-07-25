1.
SELECT * FROM invoice_line WHERE unit_price > 0.99

2.
SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total
FROM invoice
INNER JOIN customer 
ON invoice.customer_id = customer.customer_id

3.
SELECT customer.first_name, customer.last_name, employee.first_name, employee.last_name
FROM customer
INNER JOIN employee
ON customer.support_rep_id = employee.employee_id

4.
SELECT album.title, artist.name 
FROM album
INNER JOIN artist
ON album.artist_id = artist.artist_id

5.
SELECT playlist_track.track_id
FROM playlist_track
INNER JOIN playlist
ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music'

6.
SELECT track.name
FROM track
INNER JOIN playlist_track
ON track.track_id = playlist_track.track_id
WHERE playlist_track.playlist_id = 5

7.
SELECT track.name, playlist.name
FROM track
INNER JOIN playlist_track
ON track.track_id = playlist_track.track_id
INNER JOIN playlist
ON playlist_track.playlist_id = playlist.playlist_id

8.
SELECT track.name, album.title
FROM track
INNER JOIN album
ON track.album_id = album.album_id
INNER JOIN genre
ON genre.genre_id = track.genre_id


//NESTED Querys
1.
SELECT * FROM invoice WHERE invoice_id IN(
	SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99
)

2.
SELECT *  FROM playlist_track WHERE playlist_id IN(
	SELECT playlist_id FROM playlist WHERE name = 'Music'
)

3.
SELECT name  FROM track WHERE track_id
 IN(
	SELECT track_id FROM playlist_track WHERE playlist_id = 5
)

4.
SELECT * FROM track WHERE genre_id IN(
	SELECT genre_id FROM genre WHERE name = 'Comedy'
)

5.
SELECT * FROM track WHERE album_id
 IN(
	SELECT album_id
 FROM album WHERE title = 'Fireball'
)


//Updating
1. 
UPDATE customers
SET fax = null

2.
UPDATE customer
SET company = 'Self'
WHERE company IS null

3.
UPDATE customer
SET last_name = 'Thompson'
WHERE last_name = 'Self' AND first_name = 'Julia';

4.
UPDATE customer 
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'

5.
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Metal')

//GROUP BY
1.
SELECT COUNT(*), genre.name
FROM track 
INNER JOIN genre
ON track.genre_id = genre.genre_id
GROUP BY genre.name

2.
SELECT COUNT(*), genre.name
FROM track 
INNER JOIN genre
ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock' OR genre.name = 'Pop'
GROUP BY genre.name

3.
SELECT COUNT(*), artist.name
FROM album
INNER JOIN artist
ON album.artist_id = artist.artist_id
GROUP BY artist.name

//DELETE ROWS

1.
DELETE 
FROM practice_delete 
WHERE type = 'bronze'

2.
DELETE 
FROM practice_delete 
WHERE type = 'silver'

3.
DELETE 
FROM practice_delete 
WHERE value = 150


//E-COMMERCE

//Creating table
CREATE TABLE users (id SERIAL PRIMARY KEY, name varchar(255) NOT NULL, email varchar(255)) 


CREATE TABLE product (id SERIAL PRIMARY KEY, name varchar(255) NOT NULL, price NUMERIC) 

CREATE TABLE orders (id SERIAL PRIMARY KEY, product_id INTEGER REFERENCES product(id), customer_id INTEGER REFERENCES product(id)) 


//creating data
INSERT INTO users (name, email)
VALUES
('PHILIP SCHULTZ', 'devmtnbad.com'),
('JOHN STAMON', 'devmtngood.com'),
('PAM ARBA', 'devmtnok.com')


INSERT INTO product (name, price)
VALUES
('box', 5.00),
('knife', 19.99),
('pan', 24.99)

INSERT INTO orders (product_id, customer_id)
VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 1),
(3,3),
(3,1)

// GETTING ALL orders
SELECT * FROM orders

//getting first order
SELECT product.name, orders.id 
FROM product
INNER JOIN orders
ON product.id = orders.product_id
WHERE orders.id = 1

//getting order totals
SELECT orders.id, product.price 
FROM orders
INNER JOIN product
ON orders.product_id = product.id

//Get all orders for a user.

SELECT orders.*, users.name 
FROM orders
INNER JOIN users
ON orders.customer_id = users.id
WHERE orders.customer_id = 1


SELECT COUNT(*), users.name 
FROM orders
INNER JOIN users
ON orders.customer_id = users.id
GROUP BY users.name


