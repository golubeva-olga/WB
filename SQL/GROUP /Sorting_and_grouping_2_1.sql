SELECT 
    seller_id, 
    COUNT(category) AS total_categ, 
    ROUND(AVG(rating)::numeric, 2) AS avg_rating, 
    SUM(revenue) AS total_revenue, 
    CASE 
        WHEN (COUNT(category) > 1 AND SUM(revenue) > 50000) THEN 'rich'
        WHEN (COUNT(category) > 1 AND SUM(revenue) <= 50000) THEN 'poor'
       
    END AS seller_type
FROM sellers
WHERE category != 'Bedding' 
GROUP BY seller_id
HAVING COUNT(category) > 1  -- В чате обсуждали, что тех кто не попал ни в poor,
--ни в reach выводить не надо(это те у кого 1 категория ), 
--если все-таки надо вывести всех, то закомментируйте эту строку.
ORDER BY seller_id;


