CREATE DATABASE Ventas_online;
USE Ventas_online;

-- Tabla Productos
CREATE TABLE Productos (
    codigo_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);

-- Tabla Clientes
CREATE TABLE Clientes (
    dni_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE
);

-- Tabla Ordenes
CREATE TABLE Ordenes (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    codigo_producto INT NOT NULL,
    dni_cliente INT NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    total DECIMAL(10,2),
    FOREIGN KEY (codigo_producto)
        REFERENCES Productos(codigo_producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    
    FOREIGN KEY (dni_cliente)
        REFERENCES Clientes(dni_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- INSERTS
INSERT INTO Productos (codigo_producto, nombre_producto, precio, stock) VALUES
(1, 'Yerba Mate 1kg', 4200.00, 50),
(2, 'Azúcar 1kg', 1200.00, 80),
(3, 'Harina 000 1kg', 900.00, 100),
(4, 'Aceite Girasol 1L', 3500.00, 40),
(5, 'Arroz 1kg', 1300.00, 70),
(6, 'Fideos Spaghetti 500g', 800.00, 60),
(7, 'Gaseosa Cola 2.25L', 2500.00, 30),
(8, 'Leche Entera 1L', 1100.00, 90),
(9, 'Café Molido 500g', 3800.00, 25),
(10, 'Galletitas Chocolinas', 1500.00, 55);

INSERT INTO Clientes (dni_cliente, nombre, apellido, email) VALUES
(40111222, 'Juan', 'Pérez', 'juan.perez@gmail.com'),
(40999888, 'María', 'Gómez', 'maria.gomez@gmail.com'),
(35000444, 'Luis', 'Rodríguez', 'luis.rodri@hotmail.com'),
(38999111, 'Camila', 'López', 'cami.lopez@yahoo.com'),
(40222333, 'Mateo', 'Sánchez', 'mateo.san@gmail.com'),
(37777888, 'Lucía', 'Martínez', 'lucia.mtz@gmail.com'),
(36666111, 'Sofía', 'Fernández', 'sofi.fer@hotmail.com'),
(34444999, 'Tomás', 'Ramos', 'tomas.r@gmail.com'),
(41122334, 'Julián', 'Díaz', 'julian.dz@gmail.com'),
(39555666, 'Valentina', 'Suárez', 'valen.suarez@yahoo.com');

INSERT INTO Ordenes (id_orden, codigo_producto, dni_cliente, cantidad, fecha, total) VALUES
(1, 1, 40111222, 1, '2025-01-10', 4200.00),
(2, 3, 40999888, 2, '2025-01-12', 1800.00),
(3, 5, 35000444, 1, '2025-01-15', 1300.00),
(4, 2, 38999111, 3, '2025-01-15', 3600.00),
(5, 8, 40222333, 4, '2025-01-18', 4400.00),
(6, 10, 37777888, 1, '2025-01-20', 1500.00),
(7, 4, 36666111, 2, '2025-01-21', 7000.00),
(8, 7, 34444999, 1, '2025-01-22', 2500.00),
(9, 6, 41122334, 5, '2025-01-25', 4000.00),
(10, 9, 39555666, 1, '2025-01-27', 3800.00);
