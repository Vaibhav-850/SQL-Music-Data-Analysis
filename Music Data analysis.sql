CREATE DATABASE MUSIC ;
USE MUSIC;
DROP TABLE Album; 
ALTER TABLE ALBUM2
RENAME TO ALBUM;


/* Q1: Who is the senior most employee based on job title? */

SELECT *FROM EMPLOYEE
ORDER BY LEVELS DESC
LIMIT 1;
---------------------------------------------------------------------------------------------------


/* Q2: Which countries have the most Invoices? */

SELECT COUNT(*) AS TOTAL_COUNT, BILLING_COUNTRY
FROM INVOICE
GROUP BY BILLING_COUNTRY
ORDER BY TOTAL_COUNT DESC ;
------------------------------------------------------------------------------------------------------


/* Q3: What are top 3 values of total invoice? */

SELECT TOTAL FROM INVOICE
ORDER BY TOTAL DESC
LIMIT 3;
-------------------------------------------------------------------------------------------------------



/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */


SELECT SUM(TOTAL) AS TOTAL_INVOICE, BILLING_CITY
FROM INVOICE
GROUP BY BILLING_CITY
ORDER BY TOTAL_INVOICE DESC;
----------------------------------------------------------------------------------------------------------




/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/


SELECT CUSTOMER.CUSTOMER_ID, CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME, SUM(INVOICE.TOTAL) AS TOTAL_SPENDING
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
GROUP BY CUSTOMER.CUSTOMER_ID, CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME
ORDER BY TOTAL_SPENDING DESC
LIMIT 1;
----------------------------------------------------------------------------------------------------------------------



/* Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;
---------------------------------------------------------------------------------------------------------------------



/* Q7: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC
LIMIT 10; 
-----------------------------------------------------------------------------------------------------------------------------

/* Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT NAME, MILLISECONDS
FROM TRACK
WHERE MILLISECONDS > (
SELECT AVG(MILLISECONDS) AS AVG_TRACK_LENGTH
FROM TRACK )
ORDER BY MILLISECONDS DESC;
--------------------------------------------------------------------------------------------------------------------------


SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1;








