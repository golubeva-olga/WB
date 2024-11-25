SELECT city, age, COUNT(id) AS users_number
FROM users
GROUP BY city, age
ORDER BY users_number DESC
