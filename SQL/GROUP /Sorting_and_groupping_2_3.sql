SELECT seller_id, STRING_AGG(category, '-'  ORDER BY category) AS category_pair
FROM sellers
WHERE DATE_PART('year', date_reg::DATE) = 2022
GROUP BY seller_id
HAVING COUNT(category) = 2 AND SUM (revenue) > 75000   



