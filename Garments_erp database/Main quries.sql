CREATE DATABASE garments_erp;
USE garments_erp;

-- Create Orders Table (Main Job Order)
CREATE TABLE Orders (
    JobNo INT PRIMARY KEY AUTO_INCREMENT,
    OrderNo VARCHAR(50) NOT NULL UNIQUE,
    OrderStatus VARCHAR(20) NOT NULL CHECK (OrderStatus IN ('Confirmed', 'Projected')),
    PONo VARCHAR(50),
    POReceivedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ShipmentDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Yarn Allocation Table
CREATE TABLE YarnAllocation (
    AllocationID INT PRIMARY KEY AUTO_INCREMENT,
    JobNo INT NOT NULL,
    AllocationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    YarnType VARCHAR(100) NOT NULL,
    Quantity DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (JobNo) REFERENCES Orders(JobNo)
);

-- Knitting Production Table
CREATE TABLE Knitting (
    KnittingID INT PRIMARY KEY AUTO_INCREMENT,
    JobNo INT NOT NULL,
    ProductionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    GreyFabricQty DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (JobNo) REFERENCES Orders(JobNo)
);

-- Dyeing Batch Table
CREATE TABLE DyeingBatch (
    BatchID INT PRIMARY KEY AUTO_INCREMENT,
    JobNo INT NOT NULL,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (JobNo) REFERENCES Orders(JobNo)
);

-- Dyeing Production Table
CREATE TABLE DyeingProduction (
    DyeingID INT PRIMARY KEY AUTO_INCREMENT,
    BatchID INT NOT NULL,
    DyeingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    DyedQty DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (BatchID) REFERENCES DyeingBatch(BatchID)
);

-- Finish Fabric Table
CREATE TABLE FinishFabric (
    FinishID INT PRIMARY KEY AUTO_INCREMENT,
    JobNo INT NOT NULL,
    FinishDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FinishedQty DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (JobNo) REFERENCES Orders(JobNo)
);

-- Cutting Table
CREATE TABLE Cutting (
    CuttingID INT PRIMARY KEY AUTO_INCREMENT,
    JobNo INT NOT NULL,
    CuttingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PiecesCut INT NOT NULL,
    FOREIGN KEY (JobNo) REFERENCES Orders(JobNo)
);

-- Sewing Input Table
CREATE TABLE SewingInput (
    SewingInputID INT PRIMARY KEY AUTO_INCREMENT,
    JobNo INT NOT NULL,
    InputDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PiecesIn INT NOT NULL,
    FOREIGN KEY (JobNo) REFERENCES Orders(JobNo)
);

-- Sewing Output Table
CREATE TABLE SewingOutput (
    SewingOutputID INT PRIMARY KEY AUTO_INCREMENT,
    JobNo INT NOT NULL,
    OutputDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PiecesOut INT NOT NULL,
    FOREIGN KEY (JobNo) REFERENCES Orders(JobNo)
);

-- Packing Table
CREATE TABLE Packing (
    PackingID INT PRIMARY KEY AUTO_INCREMENT,
    JobNo INT NOT NULL,
    PackingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PackedQty INT NOT NULL,
    FOREIGN KEY (JobNo) REFERENCES Orders(JobNo)
);

-- Delivery Table
CREATE TABLE Delivery (
    DeliveryID INT PRIMARY KEY AUTO_INCREMENT,
    JobNo INT NOT NULL,
    DeliveryDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    DeliveredQty INT NOT NULL,
    FOREIGN KEY (JobNo) REFERENCES Orders(JobNo)
);
