SELECT 
  country,
  SUM(ordered_revenue) AS total_ordered_revenue,
  SUM(shipped_revenue) AS total_shipped_revenue,
  SUM(shipped_units) AS total_shipped_units,
  ROUND(SUM(shipped_revenue) - SUM(shipped_cogs), 2) AS gross_margin,
  ROUND((SUM(shipped_revenue) - SUM(shipped_cogs)) / NULLIF(SUM(shipped_revenue), 0) * 100, 2) AS gross_margin_percentage
FROM 
  `etail-335818.etail_prod.sales`
WHERE 
  client = '{{client}}'
  AND DATE(start_date) BETWEEN '{{start_date}}' AND '{{end_date}}'
GROUP BY 
  country
ORDER BY 
  total_shipped_revenue DESC;
