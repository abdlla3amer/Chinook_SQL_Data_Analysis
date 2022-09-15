/* Query 1 - Who are the Top 10 Selling Composers? */
SELECT t.Composer AS composer, COUNT(*) AS no_sales
  FROM Track t
  JOIN InvoiceLine il
  ON t.TrackId = il.TrackId
  JOIN Invoice i
  ON i.InvoiceId = il.InvoiceId
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 11;
