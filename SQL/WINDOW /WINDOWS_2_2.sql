SELECT DISTINCT city as CITY, date as DATE_,
ROUND( CAST(SUM(price*qty)  OVER(PARTITION BY date, city) / SUM(price*qty) OVER(PARTITION BY date ) as numeric), 2) as SUM_SALES_REL

FROM (SELECT  shopnumber,  city, address, qty, id_good, date
FROM sales LEFT JOIN  shops  using(shopnumber)
) t  LEFT JOIN goods using(id_good)
WHERE category = 'ЧИСТОТА'
ORDER BY date;


-- Формулировка не совсем понятная,  исходя из финальных колонок, видимо, просят найти процент от продаж каждого города в дату. 
-- Хотя, по фоормулировке, как будто, надо найти процент продаж в конкретную дату от суммы продаж во все даты, но зачем тогда на выходе город ????? 
-- Но вот запрос и для этого варианта

--SELECT DISTINCT city as CITY, date as DATE_,
--ROUND( CAST(SUM(price*qty)  OVER(PARTITION BY date) / SUM(price*qty) OVER( ) as numeric), 2) as SUM_SALES_REL
--FROM (SELECT  shopnumber,  city, address, qty, id_good, date
--FROM sales LEFT JOIN  shops  using(shopnumber)
--) t  LEFT JOIN goods using(id_good)
--WHERE category = 'ЧИСТОТА'
--ORDER BY date
