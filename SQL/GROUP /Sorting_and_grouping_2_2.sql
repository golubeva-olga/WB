WITH q1 AS (SELECT seller_id,
CASE WHEN ( (count(category) >1 )  AND (SUM(revenue)) > 50000) THEN 'rich'
WHEN ( (count(category) >1 )  AND (SUM(revenue)) < 50000) THEN 'poor'
END  as seller_type
FROM sellers  WHERE category != 'Bedding' 
GROUP BY seller_id
HAVING count(category)> 1  -- В чате обсуждали, что тех кто не попал ни в poor, ни в reach выводить не надо(это те у кого 1 категория ), если все-таки надо вывести всех, то закомментируйте эту строку.
)

SELECT  seller_id,  
		(EXTRACT(EPOCH FROM  AGE(current_date, date_reg:: DATE))/3600/24/30 )::INTEGER as month_from_registration,
		 (SELECT MAX(delivery_days) - MIN(delivery_days)   
		  FROM sellers
		   WHERE seller_id IN (SELECT seller_id FROM q1 WHERE seller_type = 'poor') )  AS max_delivery_difference

FROM sellers
WHERE seller_id IN (SELECT seller_id FROM q1 WHERE seller_type = 'poor') 



