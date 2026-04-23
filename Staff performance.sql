-- Payment outcomes by method
SELECT  PAYMENT.Method,
        COUNT(*) AS NumberOfPayments,
        SUM(PAYMENT.Status = 'Approved') AS NumberApproved,
        SUM(PAYMENT.Status = 'Declined') AS NumberDeclined,
        SUM(PAYMENT.Status = 'Refunded') AS NumberRefunded,
        SUM(PAYMENT.Status = 'Pending')  AS NumberPending,
        ROUND(100 * SUM(PAYMENT.Status = 'Declined') / COUNT(*), 2) AS DeclinedPercentage,
        ROUND(100 * SUM(PAYMENT.Status = 'Refunded') / COUNT(*), 2) AS RefundedPercentage
FROM    PAYMENT
WHERE   PAYMENT.PaymentDateTime >= NOW() - INTERVAL 30 DAY
GROUP BY PAYMENT.Method
ORDER BY DeclinedPercentage DESC, RefundedPercentage DESC;

-- Refund/decline exposure by outlet
SELECT  ORDERS.OutletID,
        COUNT(*) AS NumberOfPayments,
        SUM(PAYMENT.Status = 'Declined') AS NumberDeclined,
        SUM(PAYMENT.Status = 'Refunded') AS NumberRefunded,
        ROUND(100 * SUM(PAYMENT.Status = 'Declined') / COUNT(*), 2) AS DeclinedPercentage,
        ROUND(100 * SUM(PAYMENT.Status = 'Refunded') / COUNT(*), 2) AS RefundedPercentage
FROM    PAYMENT
JOIN    ORDERS
        ON ORDERS.OrderID = PAYMENT.OrderID
WHERE   PAYMENT.PaymentDateTime >= NOW() - INTERVAL 30 DAY
GROUP BY ORDERS.OutletID
ORDER BY RefundedPercentage DESC, DeclinedPercentage DESC;
