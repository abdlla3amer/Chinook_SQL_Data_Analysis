/* Query 3 - What is the Proportion of Sold Tracks for Each Media Type? */
WITH media_sales AS (
		SELECT m.name AS media_type, COUNT(*) AS no_sales
		  FROM MediaType m
		  JOIN Track t
		  ON m.MediaTypeId = t.MediaTypeId
		  JOIN InvoiceLine il
		  ON t.TrackId = il.TrackId
		  JOIN Invoice i
		  ON i.InvoiceId = il.InvoiceId
		 GROUP BY 1
		 ORDER BY 2 DESC),

     media_total AS (
		SELECT ms.media_type, ms.no_sales, (SELECT SUM(no_sales) FROM media_sales) AS total_sales
		  FROM media_sales ms)

SELECT mt.*, CASE WHEN mt.total_sales  = 0 THEN 0
	     ELSE ROUND(CAST(mt.no_sales AS REAL) / CAST(mt.total_sales AS REAL) * 100, 2) END AS proportion_of_sales
  FROM media_total mt;
