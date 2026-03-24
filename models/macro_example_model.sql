
-- tanpa macro
-- SELECT
--   sales_date,
--   SUM(quantity_sold * unit_sell_price) AS total_revenue
-- FROM sleekmart_oms.training.sales_india
-- GROUP BY
--   sales_date

-- dengan macro
SELECT
  sales_date,
  {{ calc_total_revenue('quantity_sold', 'unit_sell_price') }} AS total_revenue
FROM SLEEKMART_OMS.training.sales_india
GROUP BY
  sales_date


  
