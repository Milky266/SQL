WITH SalesByOutletAndDay AS (
  SELECT 
    ORDERS.OutletID AS OutletID,
    DATE(ORDERS.OrderDateTime) AS OrderDay,
    ROUND(SUM(ORDER_DETAIL.LineTotal), 2) AS TotalSalesAmount
  FROM ORDERS
  JOIN ORDER_DETAIL 
       ON ORDER_DETAIL.OrderID = ORDERS.OrderID
  WHERE ORDERS.Status IN ('Finished','In progress')
  GROUP BY ORDERS.OutletID, DATE(ORDERS.OrderDateTime)
),
HoursByOutletAndDay AS (
  SELECT 
    STAFF.OutletID AS OutletID,
    SHIFT.ShiftDate AS WorkDay,
    ROUND(SUM(STAFFSHIFT.ActualHours), 2) AS TotalHoursWorked
  FROM STAFFSHIFT
  JOIN SHIFT 
       ON SHIFT.ShiftID = STAFFSHIFT.ShiftID
  JOIN STAFF 
       ON STAFF.StaffID = STAFFSHIFT.StaffID
  GROUP BY STAFF.OutletID, SHIFT.ShiftDate
)
SELECT 
  SalesByOutletAndDay.OutletID,
  SalesByOutletAndDay.OrderDay,
  SalesByOutletAndDay.TotalSalesAmount,
  HoursByOutletAndDay.TotalHoursWorked,
  ROUND(
    SalesByOutletAndDay.TotalSalesAmount / NULLIF(HoursByOutletAndDay.TotalHoursWorked, 0),
    2
  ) AS SalesPerStaffHour
FROM SalesByOutletAndDay
LEFT JOIN HoursByOutletAndDay
  ON HoursByOutletAndDay.OutletID = SalesByOutletAndDay.OutletID
 AND HoursByOutletAndDay.WorkDay = SalesByOutletAndDay.OrderDay
ORDER BY SalesByOutletAndDay.OrderDay, SalesByOutletAndDay.OutletID;