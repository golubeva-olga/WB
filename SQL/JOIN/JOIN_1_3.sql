WITH q1 as ( SELECT name,   order_ammount,  CASE 
WHEN order_status = 'Cancel' THEN 1
ELSE 0 END AS Is_cancel,
CASE 
WHEN  ((AGE(shipment_date, order_date) > INTERVAL '5 days') AND ( order_status != 'Cancel' )) THEN 1
ELSE 0 END AS Is_time_lag
FROM orders  LEFT JOIN customers using(customer_id ))

SELECT name, sum(is_cancel) as cancel_orders, sum(is_time_lag) as time_lag_orders, 
   (sum(is_cancel) + sum(is_time_lag) ) as  sum_orders
  -- sum(order_ammount) FILTER (WHERE is_cancel = 1) as sum_ammount_cancel, 
  -- sum(order_ammount) FILTER (WHERE is_time_lag = 1) as sum_ammount_time_lag, 
   -- sum(order_ammount) as sum_ammount
FROM q1
WHERE (is_cancel = 1 OR is_time_lag = 1) 
GROUP BY name
ORDER BY sum_orders DESC
-- Я не очень поянла из формулировки, какая сумма имеется в виду 