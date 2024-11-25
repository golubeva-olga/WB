SELECT   DISTINCT shopnumber,  city, address, 
SUM(qty) OVER (PARTITION BY  shopnumber, address, city) AS SUM_QTY,
SUM(qty * price) OVER (PARTITION BY   shopnumber, address, city) AS SUM_QTY_PRICE

FROM (SELECT  shopnumber,  city, address, qty, id_good
FROM sales LEFT JOIN  shops  using(shopnumber)
WHERE (date::DATE) = '2016-01-02') t  LEFT JOIN goods using(id_good)

 



