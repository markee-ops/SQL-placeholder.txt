-- Join invoices to payments
SELECT 
    i.InvoiceID,
    i.Invoice_Number,
    i.Invoice_Amount,
    p.Payment_Amount,
    p.Payment_Date
FROM AP_INVOICES i
LEFT JOIN AP_PAYMENTS p 
    ON i.InvoiceID = p.InvoiceID;

-- Vendor totals
SELECT 
    VendorID, 
    SUM(Invoice_Amount) AS TotalVendorSpend
FROM AP_INVOICES
GROUP BY VendorID;

-- Exceptions by type
SELECT 
    Exception_Type, 
    COUNT(*) AS CountByType
FROM AP_EXCEPTIONS
GROUP BY Exception_Type;
