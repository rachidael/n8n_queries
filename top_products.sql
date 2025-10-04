SELECT 
  asin,
  SUM(ordered_units) AS total_ordered_units,
  SUM(shipped_units) AS total_shipped_units,
  SUM(shipped_revenue) AS total_revenue
FROM 
  `etail-335818.etail_prod.sales`
WHERE 
  client = '{{client}}'
  AND country = '{{country}}'
  AND DATE(start_date) BETWEEN '{{start_date}}' AND '{{end_date}}'
GROUP BY 
  asin
ORDER BY 
  total_ordered_units DESC
LIMIT 10;
