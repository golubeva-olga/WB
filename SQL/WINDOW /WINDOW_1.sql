WITH max_salary_t as (SELECT industry, MAX(salary) as max_ind_salary
FROM salary
GROUP BY industry),

max_salary_person as (SELECT   CONCAT(s.first_name, ' ', s.last_name) AS full_name,  s.industry as industry, s.salary
FROM salary s INNER JOIN   max_salary_t  ms ON   
(s.industry = ms.industry AND s.salary = ms.max_ind_salary))

SELECT sn.first_name, sn.last_name, industry,  sn.salary, full_name as name_highest_salary
FROM salary sn
LEFT JOIN max_salary_person  using(industry)
ORDER BY industry;


WITH min_salary_t as (SELECT industry, MIN(salary) as min_ind_salary
FROM salary
GROUP BY industry),

max_salary_person as (SELECT   CONCAT(s.first_name, ' ', s.last_name) AS full_name,  s.industry as industry, s.salary
FROM salary s INNER JOIN   min_salary_t  ms ON   
(s.industry = ms.industry AND s.salary = ms.min_ind_salary))

SELECT sn.first_name, sn.last_name, industry,  sn.salary, full_name as name_lowest_salary
FROM salary sn
LEFT JOIN max_salary_person  using(industry)
ORDER BY industry;

SELECT first_name, last_name, salary,  industry,  
FIRST_VALUE( CONCAT(first_name, ' ', last_name)) OVER(PARTITION BY industry
 ORDER BY salary RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS name_lowest_salary,
 LAST_VALUE( CONCAT(first_name, ' ', last_name)) OVER(PARTITION BY industry
 ORDER BY salary RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)  AS name_highest_salary
FROM salary