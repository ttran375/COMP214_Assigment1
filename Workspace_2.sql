--Question 2 List the shipper id, shipping company and freight cost for the order with the lowest freight charge. 2 marks
SELECT
    SHIPVIA AS SHIPPERID,
    (
        SELECT
            COMPANYNAME
        FROM
            SHIPPERS
        WHERE
            SHIPPERID = ORDERS.SHIPVIA
    ) AS COMPANYNAME,
    FREIGHT AS LOWEST_FREIGHT_COST
FROM
    ORDERS
WHERE
    FREIGHT = (
        SELECT
            MIN(FREIGHT)
        FROM
            ORDERS
    );
