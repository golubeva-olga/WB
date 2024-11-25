SELECT name,  SUM(order_ammount) AS sum_order_ammount, AVG(AGE( shipment_date, order_date)) as avg_time_lag  
FROM orders  LEFT JOIN customers using(customer_id)
GROUP BY customer_id, name
HAVING COUNT(order_id) =  (SELECT MAX(counts) FROM ( SELECT COUNT(order_id) as counts FROM orders GROUP BY customer_id) t)
ORDER BY sum_order_ammount


--  На всякий случай запрос  в котором  не учитываются отмененные заказы,
-- потому что например в таблице есть ситуации где заказ создан и сразу отменен 

--SELECT name, COUNT(order_id) AS num_orders, SUM(order_ammount) AS sum_order_ammount,AVG(AGE( shipment_date, order_date))  
--FROM orders  LEFT JOIN customers using(customer_id)
--WHERE order_status =  'Approved'
--GROUP BY customer_id, name
--HAVING COUNT(order_id) =  (SELECT MAX(counts) FROM ( SELECT COUNT(order_id) as counts FROM orders 
--													WHERE order_status =  'Approved' GROUP BY customer_id) t)


