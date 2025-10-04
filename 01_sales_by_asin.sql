SELECT 
  asin,
  SUM(ordered_revenue) AS total_ordered_revenue,
  SUM(ordered_units) AS total_ordered_units,
  SUM(shipped_revenue) AS total_shipped_revenue,
  SUM(shipped_units) AS total_shipped_units,
  SUM(shipped_cogs) AS total_cogs,
  ROUND(SUM(shipped_revenue) - SUM(shipped_cogs), 2) AS gross_margin,
  ROUND((SUM(shipped_revenue) - SUM(shipped_cogs)) / NULLIF(SUM(shipped_revenue), 0) * 100, 2) AS gross_margin_percentage
FROM 
  `etail-335818.etail_prod.sales`
WHERE 
  client = '{{client}}'
  AND country = '{{country}}'
  AND DATE(start_date) >= DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH)
GROUP BY 
  asin
ORDER BY 
  total_shipped_revenue DESC;
