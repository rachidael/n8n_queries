WITH period1 AS (
  SELECT 
    SUM(shipped_revenue) AS revenue,
    SUM(shipped_units) AS units,
    SUM(shipped_cogs) AS cogs
  FROM `etail-335818.etail_prod.sales`
  WHERE client = '{{client}}'
    AND country = '{{country}}'
    AND DATE(start_date) BETWEEN '{{start_date}}' AND '{{end_date}}'
),
period2 AS (
  SELECT 
    SUM(shipped_revenue) AS revenue,
    SUM(shipped_units) AS units,
    SUM(shipped_cogs) AS cogs
  FROM `etail-335818.etail_prod.sales`
  WHERE client = '{{client}}'
    AND country = '{{country}}'
    AND DATE(start_date) BETWEEN '{{compare_start_date}}' AND '{{compare_end_date}}'
)
SELECT
  p1.revenue AS period1_revenue,
  p2.revenue AS period2_revenue,
  ROUND(((p1.revenue - p2.revenue) / NULLIF(p2.revenue,0)) * 100, 2) AS revenue_variation_percentage,
  p1.units AS period1_units,
  p2.units AS period2_units,
  ROUND(((p1.units - p2.units) / NULLIF(p2.units,0)) * 100, 2) AS units_variation_percentage,
  (p1.revenue - p1.cogs) AS period1_margin,
  (p2.revenue - p2.cogs) AS period2_margin,
  ROUND((((p1.revenue - p1.cogs) - (p2.revenue - p2.cogs)) / NULLIF((p2.revenue - p2.cogs),0)) * 100, 2) AS margin_variation_percentage
FROM period1 p1, period2 p2;
