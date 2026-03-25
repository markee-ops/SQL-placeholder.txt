CREATE TABLE AP_INVOICES (
    InvoiceID INT PRIMARY KEY,
    VendorID INT,
    Invoice_Number VARCHAR(50),
    Invoice_Date DATE,
    Invoice_Amount DECIMAL(10,2),
    Status VARCHAR(20),
    ReceiptID INT
);

CREATE TABLE AP_PAYMENTS (
    PaymentID INT PRIMARY KEY,
    InvoiceID INT,
    Payment_Amount DECIMAL(10,2),
    Payment_Date DATE
);

CREATE TABLE AP_EXCEPTIONS (
    ExceptionID INT PRIMARY KEY,
    InvoiceID INT,
    Exception_Type VARCHAR(50),
    Exception_Description VARCHAR(255)
);
