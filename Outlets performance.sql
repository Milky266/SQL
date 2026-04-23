WITH OrdersInLast30Days AS (
  SELECT  ORDERS.OutletID, ORDERS.OrderID, ORDERS.OrderType, ORDERS.Status, ORDERS.OrderDateTime
  FROM    ORDERS
  WHERE   ORDERS.OrderDateTime >= NOW() - INTERVAL 30 DAY
),
FinishedOrderTotals AS (
  SELECT  OrdersInLast30Days.OutletID,
          OrdersInLast30Days.OrderID,
          SUM(ORDER_DETAIL.LineTotal) AS OrderTotal
  FROM    OrdersInLast30Days
  JOIN    ORDER_DETAIL
          ON ORDER_DETAIL.OrderID = OrdersInLast30Days.OrderID
  WHERE   OrdersInLast30Days.Status = 'Finished'
  GROUP BY OrdersInLast30Days.OutletID, OrdersInLast30Days.OrderID
),
RevenueByOutlet AS (
  SELECT  FinishedOrderTotals.OutletID,
          COUNT(*) AS NumberOfFinishedOrders,
          ROUND(SUM(FinishedOrderTotals.OrderTotal), 2) AS TotalRevenue,
          ROUND(AVG(FinishedOrderTotals.OrderTotal), 2) AS AverageOrderValue
  FROM    FinishedOrderTotals
  GROUP BY FinishedOrderTotals.OutletID
),
OrderHealthByOutlet AS (
  SELECT  OrdersInLast30Days.OutletID,
          SUM(OrdersInLast30Days.OrderType = 'Dine-in' AND OrdersInLast30Days.Status = 'Finished') AS NumberOfDineInFinishedOrders,
          SUM(OrdersInLast30Days.Status = 'Cancelled') AS NumberOfCancelledOrders,
          COUNT(*) AS NumberOfAllOrders
  FROM    OrdersInLast30Days
  GROUP BY OrdersInLast30Days.OutletID
),
ReservationHealthByOutlet AS (
  SELECT  RESERVATION.OutletID,
          SUM(RESERVATION.Status = 'Served')    AS NumberOfReservationsServed,
          SUM(RESERVATION.Status = 'Cancelled') AS NumberOfReservationsCancelled,
          COUNT(*)                               AS NumberOfReservationsTotal
  FROM    RESERVATION
  WHERE   RESERVATION.ReservationDateTime >= NOW() - INTERVAL 30 DAY
  GROUP BY RESERVATION.OutletID
)
SELECT  RevenueByOutlet.OutletID,
        RevenueByOutlet.NumberOfFinishedOrders,
        RevenueByOutlet.TotalRevenue,
        RevenueByOutlet.AverageOrderValue,
        ROUND(100 * OrderHealthByOutlet.NumberOfDineInFinishedOrders
                / NULLIF(OrderHealthByOutlet.NumberOfAllOrders, 0), 2) AS DineInFinishedOrderSharePercentage,
        ROUND(100 * OrderHealthByOutlet.NumberOfCancelledOrders
                / NULLIF(OrderHealthByOutlet.NumberOfAllOrders, 0), 2) AS OrderCancellationPercentage,
        ReservationHealthByOutlet.NumberOfReservationsServed,
        ReservationHealthByOutlet.NumberOfReservationsCancelled,
        ReservationHealthByOutlet.NumberOfReservationsTotal,
        ROUND(100 * ReservationHealthByOutlet.NumberOfReservationsServed
                / NULLIF(ReservationHealthByOutlet.NumberOfReservationsTotal, 0), 2) AS ReservationServedPercentage
FROM    RevenueByOutlet
LEFT JOIN OrderHealthByOutlet
       ON OrderHealthByOutlet.OutletID = RevenueByOutlet.OutletID
LEFT JOIN ReservationHealthByOutlet
       ON ReservationHealthByOutlet.OutletID = RevenueByOutlet.OutletID
ORDER BY RevenueByOutlet.TotalRevenue DESC;
