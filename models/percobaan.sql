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
--     C.address,
--     S.address,
--     CASE
--         WHEN C.address = S.address THEN 'SAME ADDRESS'
--         ELSE 'DIFFERENT ADDRESS'
--     END AS address_status
-- FROM {{source('landing','cust')}} C
-- JOIN {{source('landing','ordr')}} O
--     ON C.CustomerID = O.CustomerID
-- JOIN {{source('landing','str')}} S
--     ON O.STOREID = S.STOREID
-- LIMIT 10;

-- menganalisis bulan berapa orang di kota tertentu membeli produk tertentu
SELECT
    EXTRACT(MONTH FROM O.ORDERDATE) AS order_month,
    C.CITY,
    COUNT(O.ORDERID) AS total_orders
FROM
    {{ source('landing','ordr') }} O
JOIN {{ source('landing','cust') }} C
    ON O.CustomerID = C.CustomerID
GROUP BY
    EXTRACT(MONTH FROM O.ORDERDATE),
    C.CITY;
