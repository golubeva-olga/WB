WITH q1 as (SELECT   product_category, product_name, (sum(order_ammount)) AS order_sum
FROM orders_2 LEFT JOIN products_2 using(product_id)
GROUP BY product_category, product_name
ORDER BY product_category),

q2 as (SELECT 
product_category, 
MAX(order_sum) AS max_sum
FROM  q1
GROUP BY product_category),

category_name AS (SELECT  m.product_category, m.product_name as most_value_pr
FROM q1 m INNER JOIN q2 p
ON  m.product_category = p.product_category AND  m.order_sum = p.max_sum), 

main_query AS (SELECT product_category,  SUM(order_ammount) as sum_category
FROM orders_2 LEFT JOIN products_2 using(product_id)
GROUP BY product_category),
 
max_category as (SELECT  product_category   as max_pr   
FROM main_query
WHERE sum_category = (SELECT MAX(sum_category)
FROM main_query) )

SELECT  product_category,  sum_category, (SELECT  max_pr FROM max_category) as prod,most_value_pr
FROM main_query JOIN   category_name using(product_category) 





