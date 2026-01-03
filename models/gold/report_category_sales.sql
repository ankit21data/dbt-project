SELECT 
category,
SUM(total_sales) AS total_sales
FROM {{ ref("silver_salesinfo")}}
GROUP BY category
ORDER BY total_sales DESC