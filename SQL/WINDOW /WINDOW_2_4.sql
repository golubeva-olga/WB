WITH q as (SELECT date, shopnumber, category, SUM(qty * price) AS value_
FROM (SELECT  shopnumber,  city, address, qty, id_good, date
FROM sales LEFT JOIN  shops  using(shopnumber)
) t  LEFT JOIN goods using(id_good)
WHERE city = 'СПб'
GROUP BY date, shopnumber, category )

SELECT   date, shopnumber, category, LAG(value_) OVER( PARTITION BY shopnumber, category
													     ORDER BY   date
													 ) AS PREV_SALES
FROM q
