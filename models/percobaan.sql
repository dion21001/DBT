-- SELECT 
--     C.FIRSTNAME,
--     OI.QUANTITY
-- FROM {{ source('landing', 'cust') }} C
-- JOIN {{ source('landing', 'ordr') }} O
--     ON C.CustomerID = O.CustomerID
-- JOIN {{source('landing','ordritms')}} OI
--     ON O.OrderID = OI.OrderID
-- GROUP BY 
--     C.FIRSTNAME,
--     OI.QUANTITY
-- HAVING OI.QUANTITY > 1
-- ORDER BY OI.QUANTITY DESC;

-- melihat apakah alamat customer dan alamat store sama atau tidak
-- SELECT 
--     C.city,
--     S.city,
--     CASE
--         WHEN C.city = S.city THEN 'SAME ADDRESS'
--         ELSE 'DIFFERENT ADDRESS'
--     END AS address_status,
--     SUM(OI.QUANTITY) AS total_quantity
-- FROM {{ source('landing','cust') }} C
-- JOIN {{ source('landing','ordr') }} O
--     ON C.CustomerID = O.CustomerID
-- JOIN {{ source('landing','str') }} S
--     ON O.STOREID = S.STOREID
-- JOIN {{ source('landing','ordritms') }} OI
--     ON O.OrderID = OI.OrderID
-- GROUP BY
--     C.city,
--     S.city
-- ORDER BY TOTAL_QUANTITY DESC
-- LIMIT 100;

-- menganalisis bulan berapa orang di kota tertentu membeli produk tertentu
-- SELECT
--     EXTRACT(MONTH FROM O.ORDERDATE) AS order_month,
--     C.CITY,
--     COUNT(O.ORDERID) AS total_orders
-- FROM
--     {{ source('landing','ordr') }} O
-- JOIN {{ source('landing','cust') }} C
--     ON O.CustomerID = C.CustomerID
-- GROUP BY
--     EXTRACT(MONTH FROM O.ORDERDATE),
--     C.CITY
-- ORDER BY TOTAL_ORDERS DESC;


-- pekerjaan yang paling banyak memesan produk tertentu 
-- SELECT
--     E.JOBTITLE,
--     SUM(OI.QUANTITY) AS total_quantity
-- FROM {{ source('landing','emp') }} E
-- JOIN
-- {{source('landing','ordr')}} O
-- ON E.EMPLOYEEID = O.EMPLOYEEID
-- JOIN {{source('landing','ordritms')}} OI
-- ON O.ORDERID = OI.ORDERID
-- GROUP BY
--     E.JOBTITLE
-- ORDER BY
--     total_quantity DESC;





