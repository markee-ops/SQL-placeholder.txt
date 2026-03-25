

WITH Base AS (
    SELECT
        InvoiceID,
        VendorID,
        InvoiceDate,
        DueDate,
        PaymentStatus,
        PaymentDate,

        CASE 
            WHEN PaymentDate IS NOT NULL AND PaymentDate <= DueDate THEN 1 
            ELSE 0 
        END AS OnTimePayment,

        CASE 
            WHEN PaymentStatus = 'Paid' AND PaymentDate IS NOT NULL THEN 1
            ELSE 0
        END AS CleanPayment,

        CASE 
            WHEN PaymentStatus = 'Open' THEN 1 ELSE 0 
        END AS OpenInvoice,

        CASE 
            WHEN PaymentDate IS NOT NULL 
            THEN DATEDIFF(day, InvoiceDate, PaymentDate)
            ELSE NULL
        END AS CycleTime
    FROM Invoices
),

Metrics AS (
    SELECT
        COUNT(*) AS TotalInvoices,

        AVG(OnTimePayment * 1.0) AS OnTimeRate,
        AVG(CleanPayment * 1.0) AS CleanPaymentRate,
        AVG(OpenInvoice * 1.0) AS OpenInvoiceRate,
        AVG(CycleTime * 1.0) AS AvgCycleTime
    FROM Base
)

SELECT
    TotalInvoices,
    OnTimeRate,
    CleanPaymentRate,
    OpenInvoiceRate,
    AvgCycleTime,

    /* Weighted AP Automation Readiness Score */
    (
        (OnTimeRate        * 0.40) +
        (CleanPaymentRate  * 0.30) +
        ((1 - OpenInvoiceRate) * 0.20) +
        ((1 - (AvgCycleTime / 30.0)) * 0.10)
    ) * 100 AS AP_Automation_Readiness_Score
FROM Metrics;

SELECT
    i.InvoiceID,
    i.InvoiceNumber,
    v.VendorName,
    i.InvoiceAmount,
    i.InvoiceDate,
    i.DueDate,
    p.PONumber,
    'Missing Receipt' AS ExceptionType,
    'Invoice has PO but no matching receipt' AS ExceptionDetail
FROM Invoices i
INNER JOIN Vendors v ON i.VendorID = v.VendorID
INNER JOIN PurchaseOrders p ON i.POID = p.POID
LEFT JOIN Receipts r ON p.POID = r.POID
WHERE r.ReceiptID IS NULL
SELECT
    i.InvoiceID,
    i.InvoiceNumber,
    v.VendorName,
    i.InvoiceAmount,
    i.InvoiceDate,
    i.DueDate,
    p.PONumber,
    'Duplicate Invoice' AS ExceptionType,
    'Invoice number appears more than once for the same vendor' AS ExceptionDetail
FROM Invoices i
INNER JOIN Vendors v ON i.VendorID = v.VendorID
LEFT JOIN PurchaseOrders p ON i.POID = p.POID
WHERE i.PaymentStatus = 'Open'
  AND EXISTS (
        SELECT 1
        FROM Invoices i2
        WHERE i2.InvoiceNumber = i.InvoiceNumber
          AND i2.VendorID = i.VendorID
          AND i2.InvoiceID <> i.InvoiceID
    );





    SELECT
    i.InvoiceID,
    i.InvoiceNumber,
    v.VendorName,
    i.InvoiceAmount,
    i.InvoiceDate,
    i.DueDate,
    p.PONumber,
    'Duplicate Invoice' AS ExceptionType,
    'Invoice number appears more than once for the same vendor' AS ExceptionDetail
FROM Invoices i
INNER JOIN Vendors v ON i.VendorID = v.VendorID
LEFT JOIN PurchaseOrders p ON i.POID = p.POID
WHERE i.PaymentStatus = 'Open'
  AND EXISTS (
        SELECT 1
        FROM Invoices i2
        WHERE i2.InvoiceNumber = i.InvoiceNumber
          AND i2.VendorID = i.VendorID
          AND i2.InvoiceID <> i.InvoiceID
    );


    InvoiceNumber: INV-3002
Vendor: Red River Rides

INSERT INTO Invoices (
    InvoiceNumber,
    VendorID,
    InvoiceAmount,
    InvoiceDate,
    DueDate,
    POID,
    PaymentStatus
)
SELECT
    InvoiceNumber,
    VendorID,
    InvoiceAmount,
    InvoiceDate,
    DueDate,
    POID,
    'Open'
FROM Invoices
WHERE InvoiceNumber = 'INV-3002'
  AND VendorID = (SELECT VendorID FROM Vendors WHERE VendorName = 'Red River Rides');





  (InvoiceNumber, VendorID)

  INSERT INTO Invoices (
    InvoiceNumber,
    VendorID,
    InvoiceAmount,
    InvoiceDate,
    DueDate,
    POID,
    PaymentStatus
)
VALUES (
    'INV-3001',   -- duplicate invoice number
    2,            -- different vendor ID
    12000.00,
    '2024-01-09',
    '2024-02-08',
    NULL,
    'Open'
);


INSERT INTO Invoices (
    InvoiceNumber,
    VendorID,
    InvoiceAmount,
    InvoiceDate,
    DueDate,
    POID,
    PaymentStatus
)
SELECT
    InvoiceNumber + ' ',   -- adds a trailing space (SQL treats it as different)
    VendorID,
    InvoiceAmount,
    InvoiceDate,
    DueDate,
    POID,
    'Open'
FROM Invoices
WHERE InvoiceNumber = 'INV-3001'
  AND VendorID = 1;   -- Frontier Leather Co

  INSERT INTO Invoices (
    InvoiceNumber,
    VendorID,
    InvoiceAmount,
    InvoiceDate,
    DueDate,
    POID,
    PaymentStatus
)
SELECT
    InvoiceNumber + ' ',   -- adds a trailing space (SQL treats it as different)
    VendorID,
    InvoiceAmount,
    InvoiceDate,
    DueDate,
    POID,
    'Open'
FROM Invoices
WHERE InvoiceNumber = 'INV-3001'
  AND VendorID = 1;






















SELECT
    i.InvoiceID,
    i.InvoiceNumber,
    v.VendorName,
    i.InvoiceAmount,
    i.InvoiceDate,
    i.DueDate,
    p.PONumber,
    DATEDIFF(DAY, i.DueDate, GETDATE()) AS DaysPastDue,
    'Overdue Invoice' AS ExceptionType,
    'Invoice is past the due date but still unpaid' AS ExceptionDetail
FROM Invoices i
INNER JOIN Vendors v ON i.VendorID = v.VendorID
LEFT JOIN PurchaseOrders p ON i.POID = p.POID
WHERE i.PaymentStatus = 'Open'
  AND i.DueDate < GETDATE();