WITH OrdersByOutletAndCustomer AS (
  SELECT  ORDERS.OutletID, ORDERS.CustomerID, COUNT(*) AS NumberOfOrdersForCustomerAtOutlet
  FROM    ORDERS
  WHERE   ORDERS.Status = 'Finished'
    AND   ORDERS.CustomerID IS NOT NULL
  GROUP BY ORDERS.OutletID, ORDERS.CustomerID
),
OutletReturnAggregation AS (
  SELECT  OutletID,
          SUM(CASE WHEN NumberOfOrdersForCustomerAtOutlet >= 2 THEN 1 ELSE 0 END) AS NumberOfReturningCustomers,
          COUNT(*) AS NumberOfUniqueCustomers
  FROM    OrdersByOutletAndCustomer
  GROUP BY OutletID
)
SELECT  OutletID,
        NumberOfReturningCustomers,
        NumberOfUniqueCustomers,
        ROUND(100 * NumberOfReturningCustomers / NULLIF(NumberOfUniqueCustomers, 0), 2) AS ReturningCustomerPercentage
FROM    OutletReturnAggregation
ORDER BY ReturningCustomerPercentage DESC;