-- Crear tabla Client
CREATE TABLE Client (
    ClientId INT PRIMARY KEY,
    Name VARCHAR(50),
    LastName VARCHAR(50),
    Identification VARCHAR(20)
);

-- Insertar datos en la tabla Client
INSERT INTO Client (ClientId, Name, LastName, Identification) VALUES
(1, 'Pedro', 'Pérez', '12345612'),
(2, 'Juan', 'Sanchez', '99888773'),
(3, 'María', 'Torres', '20014032'),
(4, 'Marcos', 'Vargas', '85274196'),
(5, 'Juanita', 'Lopez', '74165432');

-- Crear tabla Product
CREATE TABLE Product (
    ProductId INT PRIMARY KEY,
    Name VARCHAR(50),
    Reference VARCHAR(20)
);

-- Insertar datos en la tabla Product
INSERT INTO Product (ProductId, Name, Reference) VALUES
(1, 'Televisor', '100-342'),
(2, 'Nevera', '100-343'),
(3, 'Microondas', '100-344');

-- Crear tabla Orders
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY,
    ClientId INT,
    ProductId INT,
    Quantity INT,
    Total DECIMAL(15,2),
    FOREIGN KEY (ClientId) REFERENCES Client(ClientId),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId)
);

-- Insertar datos en la tabla Orders
INSERT INTO Orders (OrderId, ClientId, ProductId, Quantity, Total) VALUES
(1, 1, 1, 10, 15000000.00),
(2, 1, 2, 2, 3000000.00),
(3, 2, 3, 5, 2500000.00),
(4, 3, 1, 6, 9000000.00),
(5, 3, 2, 5, 15000000.00);


SELECT SUM(Quantity) AS TotalProductosOrdenados FROM Orders;


select p.Name as Producto, c.Name as Cliente, Quantity as Cantidad, o.Total  from Orders o inner join product p on p.ProductId = o.OrderId inner join client c  on c.ClientId = o.ClientId; 



SELECT 
    p.Name AS Producto, 
    p.Reference AS Referencia, 
    SUM(o.Quantity) AS Cantidad, 
    SUM(o.Total) AS Total
FROM Orders o 
INNER JOIN Product p ON p.ProductId = o.ProductId 
INNER JOIN Client c ON c.ClientId = o.ClientId
GROUP BY p.Name, p.Reference;


SELECT 
    c.Name AS Nombre, 
    c.LastName AS Apellido,  
    SUM(o.Total) AS Total
FROM Orders o 
INNER JOIN Product p ON p.ProductId = o.ProductId 
INNER JOIN Client c ON c.ClientId = o.ClientId
GROUP BY c.Name, c.LastName
HAVING SUM(o.Total) > 10000000;



CREATE TABLE interacciones 
( id SERIAL PRIMARY KEY, 
 cliente_id INT, 
 fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
 canal VARCHAR(50), 
 mensaje TEXT );

WITH recientes AS (
    SELECT cliente_id
    FROM interacciones
    WHERE fecha >= '2024-01-01'
)
SELECT cliente_id, COUNT(*) AS total_interacciones
FROM recientes
GROUP BY cliente_id
ORDER BY total_interacciones DESC
LIMIT 10;


