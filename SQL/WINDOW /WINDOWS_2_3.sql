SELECT  date as date_, shopnumber, id_good   --STRING_AGG(id_good::TEXT, ',') AS goods_list  --  можно добавить это с группировкой в последней строке, чтобы все топ3 выписывались в одной ячейке
FROM 
 (SELECT date, shopnumber, id_good,  
          ROW_NUMBER() OVER(PARTITION BY date, shopnumber ORDER BY qty  desc) as rank_v
FROM sales   LEFT JOIN goods using(id_good)  ) as q
WHERE rank_v < 4
--GROUP BY 1,  2
