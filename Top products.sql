-- Top products by units and revenue
WITH OrderFilterLast90Days AS (
  SELECT Orders.OrderID, Orders.OutletID, DATE(Orders.OrderDateTime) AS BusinessDate
  FROM   ORDERS AS Orders
  WHERE  Orders.Status = 'Finished'
    AND  Orders.OrderDateTime >= NOW() - INTERVAL 90 DAY
)
SELECT  Product.Name AS ProductName,
        SUM(ORDER_DETAIL.Qty) AS UnitsSold,
        ROUND(SUM(ORDER_DETAIL.LineTotal), 2) AS TotalRevenue
FROM    ORDER_DETAIL
JOIN    OrderFilterLast90Days
        ON OrderFilterLast90Days.OrderID = ORDER_DETAIL.OrderID
JOIN    PRODUCT AS Product
        ON Product.ProductID = ORDER_DETAIL.ProductID
GROUP BY Product.Name
ORDER BY UnitsSold DESC, TotalRevenue DESC
LIMIT 15;

-- Revenue by category
WITH OrderFilterLast90Days AS (
  SELECT Orders.OrderID
  FROM   ORDERS AS Orders
  WHERE  Orders.Status = 'Finished'
    AND  Orders.OrderDateTime >= NOW() - INTERVAL 90 DAY
)
SELECT  ProductCategory.Name AS CategoryName,
        ROUND(SUM(ORDER_DETAIL.LineTotal), 2) AS TotalRevenue
FROM    ORDER_DETAIL
JOIN    OrderFilterLast90Days
        ON OrderFilterLast90Days.OrderID = ORDER_DETAIL.OrderID
JOIN    PRODUCT
        ON PRODUCT.ProductID = ORDER_DETAIL.ProductID
JOIN    PRODUCT_CATEGORY AS ProductCategory
        ON ProductCategory.CategoryID = PRODUCT.CategoryID
GROUP BY ProductCategory.Name
ORDER BY TotalRevenue DESC;
