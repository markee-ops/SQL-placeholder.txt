
------------------------------------------------------------
-- KPI 1: Total Invoice Spend
------------------------------------------------------------
SELECT 
    SUM(Invoice_Amount) AS TotalSpend
FROM AP_INVOICES;


------------------------------------------------------------
-- KPI 2: Total Payments Made
------------------------------------------------------------
SELECT 
    SUM(Payment_Amount) AS TotalPayments
FROM AP_PAYMENTS;


------------------------------------------------------------
-- KPI 3: Outstanding Balance (Invoices - Payments)
------------------------------------------------------------
SELECT 
    (SELECT SUM(Invoice_Amount) FROM AP_INVOICES) -
    (SELECT SUM(Payment_Amount) FROM AP_PAYMENTS) AS OutstandingBalance;


------------------------------------------------------------
-- KPI 4: Exception Rate (Exceptions per Invoice)
------------------------------------------------------------
SELECT 
    COUNT(e.ExceptionID) * 1.0 / COUNT(i.InvoiceID) AS ExceptionRate
FROM AP_INVOICES i
LEFT JOIN AP_EXCEPTIONS e 
    ON i.InvoiceID = e.InvoiceID;


------------------------------------------------------------
-- KPI 5: Average Days to Pay (Invoice → Payment)
------------------------------------------------------------
SELECT 
    AVG(DATEDIFF(DAY, i.Invoice_Date, p.Payment_Date)) AS AvgDaysToPay
FROM AP_INVOICES i
INNER JOIN AP_PAYMENTS p 
    ON i.InvoiceID = p.InvoiceID;


------------------------------------------------------------
-- KPI 6: Invoices by Status
------------------------------------------------------------
SELECT 
    Status,
    COUNT(*) AS CountByStatus
FROM AP_INVOICES
GROUP BY Status;


------------------------------------------------------------
-- KPI 7: Vendor Spend Concentration (Top Vendors)
------------------------------------------------------------
SELECT 
    VendorID,
    SUM(Invoice_Amount) AS TotalVendorSpend
FROM AP_INVOICES
GROUP BY VendorID
ORDER BY TotalVendorSpend DESC;


------------------------------------------------------------
-- KPI 8: Aging Summary (0–30, 31–60, 61–90, 90+)
------------------------------------------------------------
SELECT 
    CASE 
        WHEN DATEDIFF(DAY, Invoice_Date, GETDATE()) <= 30 THEN '0-30 Days'
        WHEN DATEDIFF(DAY, Invoice_Date, GETDATE()) <= 60 THEN '31-60 Days'
        WHEN DATEDIFF(DAY, Invoice_Date, GETDATE()) <= 90 THEN '61-90 Days'
        ELSE '90+ Days'
    END AS AgingBucket,
    COUNT(*) AS InvoiceCount,
    SUM(Invoice_Amount) AS TotalAmount
FROM AP_INVOICES
GROUP BY 
    CASE 
        WHEN DATEDIFF(DAY, Invoice_Date, GETDATE()) <= 30 THEN '0-30 Days'
        WHEN DATEDIFF(DAY, Invoice_Date, GETDATE()) <= 60 THEN '31-60 Days'
        WHEN DATEDIFF(DAY, Invoice_Date, GETDATE()) <= 90 THEN '61-90 Days'
        ELSE '90+ Days'
    END
ORDER BY AgingBucket;


------------------------------------------------------------
-- KPI 9: Exception Types Summary
------------------------------------------------------------
SELECT 
    Exception_Type,
    COUNT(*) AS TotalExceptions
FROM AP_EXCEPTIONS
GROUP BY Exception_Type
ORDER BY TotalExceptions DESC;
