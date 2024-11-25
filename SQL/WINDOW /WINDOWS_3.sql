CREATE TABLE query (
    searchid  SERIAL PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    userid INT,
    ts BIGINT,
    devicetype VARCHAR(50),
    deviceid INT,
    query VARCHAR(200)
);

INSERT INTO query ( userid, ts, devicetype, deviceid, query)
VALUES
(1, 1732500000, 'android', 1, 'ш'),
(1, 1732500010, 'android', 1, 'ша'),
(1, 1732500020, 'android', 1, 'шап'),
(1, 1732500100, 'android', 1, 'шапк'),
(1, 1732500200, 'android', 1, 'шапка'),
(1, 1732500300, 'mac', 2, 'шапка'),
(2, 1732600000, 'android', 12, 'ш'),
(2, 1732600010, 'android', 12, 'ша'),
(2, 1732600620, 'android', 12, 'шаш'),
(2, 1732650100, 'android', 12, 'шашк'),
(2, 1732650200, 'android', 12, 'шашка'),
(2, 1732650300, 'mac', 22, 'шашка'),
(2, 1762600000, 'mac', 12, 'к'),
(2, 1762600010, 'mac', 12, 'кот'),
(1, 1732600620, 'mac', 12, 'ша'),
(1, 1732500270, 'android', 1, 'ша'),
(1, 1832650200, 'android', 1, 'шал'),
(1, 1832650300, 'android', 1, 'шалаш');


UPDATE query
SET 
    year = EXTRACT(YEAR FROM to_timestamp(ts)),
    month = EXTRACT(MONTH FROM to_timestamp(ts)),
    day = EXTRACT(DAY FROM to_timestamp(ts));





WITH ready_table as (SELECT   year, month, day, userid, ts , devicetype, deviceid, query, 
LEAD(query) OVER(PARTITION BY userid, devicetype order by ts) As next_query, 
-- LEAD(ts) OVER(PARTITION BY userid, devicetype order by ts)  - ts As next_query_time,  
CASE  WHEN LEAD(query) OVER(PARTITION BY userid, devicetype order by ts)  IS NULL THEN 1
WHEN (LEAD(ts) OVER(PARTITION BY userid, devicetype order by ts) - ts > 180) THEN 1
WHEN  ( (LENGTH(LEAD(query) OVER(PARTITION BY userid, devicetype ORDER BY ts)) < LENGTH(query)) 
	   AND
    (LEAD(ts) OVER(PARTITION BY userid, devicetype ORDER BY ts) - ts > 60)
) THEN 2
		 ELSE 0
END as is_final
FROM query) 

SELECT * 
FROM ready_table 
WHERE (devicetype = 'android')  AND is_final IN (1, 2)