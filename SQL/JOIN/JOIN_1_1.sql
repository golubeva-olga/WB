SELECT  DISTINCT  name
FROM orders  LEFT JOIN customers using(customer_id)
WHERE AGE(shipment_date, order_date)  = (SELECT  MAX(AGE(shipment_date, order_date))
													FROM  orders)
												
-- по тексту задания выглядит так, что этого достаточно и уникальных пользователей, 
--которые ждали одинаково долго 27, заказов таких 31. Однако, если искать подвох, то возможно 
-- нам нужны только неотмененные заказы (иначе, вдруг их отменили в пути и они так и не были доставлены). 
-- Тогда можно запустить запрос ниже там получается 13 уникальных пользователей и 15 заказов

--SELECT  DISTINCT name
--FROM orders  LEFT JOIN customers using(customer_id)
--WHERE (AGE(shipment_date, order_date)  = (SELECT  MAX(AGE(shipment_date, order_date))
--													FROM  orders)) AND (order_status =  'Approved')
													

