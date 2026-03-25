-- Join invoices to payments
------------------------------------------------------------
-- QUERY 1: Invoices With No Payments (Unpaid Invoices)
------------------------------------------------------------
SELECT 
    i.InvoiceID,
    i.Invoice_Number,
    i.Invoice_Amount,
    i.Invoice_Date,
    i.Status
FROM AP_INVOICES i
LEFT JOIN AP_PAYMENTS p 
    ON i.InvoiceID = p.InvoiceID
WHERE p.PaymentID IS NULL;


------------------------------------------------------------
-- QUERY 2: Payments Without Matching Invoices (Orphan Payments)
------------------------------------------------------------
SELECT 
    p.PaymentID,
    p.Payment_Amount,
    p.Payment_Date
FROM AP_PAYMENTS p
LEFT JOIN AP_INVOICES i 
    ON p.InvoiceID = i.InvoiceID
WHERE i.InvoiceID IS NULL;


------------------------------------------------------------
-- QUERY 3: Duplicate Invoice Numbers
------------------------------------------------------------
SELECT 
    Invoice_Number,
    COUNT(*) AS DuplicateCount
FROM AP_INVOICES
GROUP BY Invoice_Number
HAVING COUNT(*) > 1;


------------------------------------------------------------
-- QUERY 4: Exceptions Joined to Invoices
------------------------------------------------------------
SELECT 
    e.ExceptionID,
    e.Exception_Type,
    e.Exception_Description,
    i.InvoiceID,
    i.Invoice_Number,
    i.Invoice_Amount
FROM AP_EXCEPTIONS e
LEFT JOIN AP_INVOICES i 
    ON e.InvoiceID = i.InvoiceID;


------------------------------------------------------------
-- QUERY 5: Total Spend by Vendor
------------------------------------------------------------
SELECT 
    VendorID,
    SUM(Invoice_Amount) AS TotalVendorSpend
FROM AP_INVOICES
GROUP BY VendorID
ORDER BY TotalVendorSpend DESC;


------------------------------------------------------------
-- QUERY 6: Invoice Aging Buckets
------------------------------------------------------------
SELECT 
    InvoiceID,
    Invoice_Number,
    Invoice_Date,
    Invoice_Amount,
    CASE 
        WHEN DATEDIFF(DAY, Invoice_Date, GETDATE()) <= 30 THEN '0-30 Days'
        WHEN DATEDIFF(DAY, Invoice_Date, GETDATE()) <= 60 THEN '31-60 Days'
        WHEN DATEDIFF(DAY, Invoice_Date, GETDATE()) <= 90 THEN '61-90 Days'
        ELSE '90+ Days'
    END AS AgingBucket
FROM AP_INVOICES;


------------------------------------------------------------
-- QUERY 7: Exception Count by Type
------------------------------------------------------------
SELECT 
    Exception_Type,
    COUNT(*) AS CountByType
FROM AP_EXCEPTIONS
GROUP BY Exception_Type
ORDER BY CountByType DESC;


------------------------------------------------------------
-- QUERY 8: Payment Cycle Time (Invoice → Payment)
------------------------------------------------------------
SELECT 
    i.InvoiceID,
    i.Invoice_Number,
    i.Invoice_Date,
    p.Payment_Date,
    DATEDIFF(DAY, i.Invoice_Date, p.Payment_Date) AS DaysToPay
FROM AP_INVOICES i
INNER JOIN AP_PAYMENTS p 
    ON i.InvoiceID = p.InvoiceID;


------------------------------------------------------------
-- QUERY 9: Exception Rate (Exceptions per Invoice)
------------------------------------------------------------
SELECT 
    COUNT(e.ExceptionID) * 1.0 / COUNT(i.InvoiceID) AS ExceptionRate
FROM AP_INVOICES i
LEFT JOIN AP_EXCEPTIONS e 
    ON i.InvoiceID = e.InvoiceID;
