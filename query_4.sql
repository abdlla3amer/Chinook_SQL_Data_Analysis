/* Query 4 - In How Many Countries was Each Genre the Top Selling Genre? */

WITH country_genre_sales AS (
		SELECT i.BillingCountry AS billing_country, g.Name AS genre_name, COUNT(*) AS no_sales
		  FROM Genre g
		  JOIN Track t
		  ON g.GenreId = t.GenreId
		  JOIN InvoiceLine il
		  ON t.TrackId = il.TrackId
		  JOIN Invoice i
		  ON i.InvoiceId = il.InvoiceId
		 GROUP BY 1, 2),

     country_genre_max_sales AS (
		SELECT billing_country, MAX(no_sales) AS max_sales
		  FROM country_genre_sales
		 GROUP BY 1),

     winning_genres AS ( 
		SELECT cgs.billing_country AS billing_country, cgs.genre_name AS genre_name, cgs.no_sales AS max_sales
		  FROM country_genre_sales cgs
		  JOIN country_genre_max_sales cgms
		  ON cgs.billing_country = cgms.billing_country AND cgs.no_sales = cgms.max_sales)
		  
SELECT wg.genre_name, COUNT(*) AS no_countries
  FROM winning_genres wg
 GROUP BY 1
 ORDER BY 2 DESC;
