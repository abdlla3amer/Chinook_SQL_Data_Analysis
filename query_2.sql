/* Query 2 - In the Top Revenue Driving Country, who are the Top 5 Selling Artists? */
WITH top_selling_country AS (
		SELECT i.BillingCountry AS billing_country, SUM(i.Total) AS sum_sales
		  FROM Invoice i
		 GROUP BY 1
		 ORDER BY 2 DESC
		 LIMIT 1)
		 
SELECT a.ArtistId, a.Name, i.BillingCountry, COUNT(*) AS no_sales
  FROM Artist a
  JOIN Album b
  ON a.ArtistId = b.ArtistId
  JOIN Track t
  ON b.AlbumId = t.AlbumId
  JOIN InvoiceLine il
  ON t.TrackId = il.TrackId
  JOIN Invoice i
  ON i.InvoiceId = il.InvoiceId
 WHERE i.BillingCountry = (SELECT billing_country
							FROM top_selling_country)
 GROUP BY 1, 2, 3
 ORDER BY 4 DESC
 LIMIT 5;
