--Question 2 List the shipper id, shipping company and freight cost for the 
-- order with the lowest freight charge. 2 marks
SELECT
    ORDERS.SHIPVIA AS SHIPPERID,
    ORDERS.FREIGHT AS LOWEST_FREIGHT_COST,
    (
        SELECT SHIPPERS.COMPANYNAME
        FROM SHIPPERS
        WHERE SHIPPERS.SHIPPERID = ORDERS.SHIPVIA
    ) AS COMPANYNAME
FROM
    ORDERS
WHERE
    ORDERS.FREIGHT = (
        SELECT MIN(FREIGHT)
        FROM ORDERS
    );
