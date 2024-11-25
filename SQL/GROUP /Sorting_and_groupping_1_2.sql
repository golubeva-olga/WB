SELECT  category, round(CAST(AVG(price) AS numeric), 2) as avg_price
FROM products 
WHERE (name LIKE '%Hair%') Or (name LIKE '%hair%')  OR (name LIKE '%Home%') OR (name LIKE '%home%')  
GROUP BY category
