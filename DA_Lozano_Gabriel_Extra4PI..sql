--Extra Credit
Use Fast_Food
--1. Insertar Nuevos Datos a la base de datos

INSERT INTO Detalle.Detalle (IdOrden, IdProductos, Cantidad, Precio) VALUES
(1, 2, 5, 45),
(1, 3, 3, 46),
(2, 4, 4, 42),
(2, 5, 2, 18),
(2, 1, 3, 23),
(3, 2, 5, 45),
(3, 3, 4, 46),
(3, 4, 2, 42),
(4, 1, 1, 21),
(4, 2, 3, 20),
(4, 3, 2, 13),
(5, 4, 5, 18),
(6, 1, 2, 21),
(6, 2, 4, 20),
(6, 3, 3, 19),
(7, 1, 5, 18),
(7, 2, 3, 45),
(8, 3, 4, 22),
(9, 1, 2, 13),
(9, 2, 4, 40),
(10, 3, 1, 21);

--2. Mensajeros

INSERT INTO Mensajero.Mensajero (Nombre, EsExterno) VALUES
('Mensajero Once', 0),
('Mensajero Doce', 1),
('Mensajero Trece', 0),
('Mensajero Catorce', 1),
('Mensajero Quince', 0),
('Mensajero Dieciséis', 1),
('Mensajero Diecisiete', 0),
('Mensajero Dieciocho', 1),
('Mensajero Diecinueve', 0),
('Mensajero Veinte', 1),
('Mensajero Veintiuno', 0),
('Mensajero Veintidós', 1),
('Mensajero Veintitrés', 0),
('Mensajero Veinticuatro', 1),
('Mensajero Veinticinco', 0);



--3. Productos
INSERT INTO Productos.Productos (Productos, IdCategoria, Precio) 
VALUES 

('Wrap de Pollo', 1, 6.99), 
('Papas Fritas', 1, 2.49), 
('Tiramisú', 2, 5.99), 
('Gelatina', 2, 1.99), 
('Té Helado', 3, 1.49), 
('Batido de Fresa', 3, 3.49), 
('Ensalada Mediterránea', 4, 7.99), 
('Ensalada de Quinoa', 4, 6.99), 
('Croissant', 5, 2.99), 
('Jugo de Naranja', 5, 2.49), 
('Latte', 6, 3.99), 
('Espresso', 6, 2.49), 
('Helado de Mango', 7, 2.99), 
('Helado de Limón', 7, 2.99), 
('Falafel', 8, 6.99), 
('Ensalada de Kale', 8, 5.99), 
('Chuleta de Cerdo', 9, 13.99), 
('Pollo a la Parrilla', 9, 10.99), 
('Pizza Cuatro Quesos', 10, 14.99), 
('Pizza de Pollo BBQ', 10, 15.99);

SELECT * FROM Productos.Productos

SELECT * FROM Categoria.Categoria

-- 4. Sucursal

-- Sucursal 2
INSERT INTO Empleados.Empleados (Nombre, Posicion, Departamento, IdSucursal, Rol) VALUES
('Carlos Ruiz', 'Cajero', 'Ventas', 2, 'Vendedor'),
('Sofia Martinez', 'Cocinero', 'Cocina', 2, 'Cocina'),
('Pedro Hernandez', 'Repartidor', 'Logística', 2, 'Mensajero'),

-- Sucursal 3
('Diana Lopez', 'Cajero', 'Ventas', 3, 'Vendedor'),
('Jorge Ramirez', 'Cocinero', 'Cocina', 3, 'Cocina'),
('Isabel Fernandez', 'Gerente', 'Administración', 3, 'Administrador'),

-- Sucursal 4
('Juan Morales', 'Cajero', 'Ventas', 4, 'Vendedor'),
('Laura Castillo', 'Cocinero', 'Cocina', 4, 'Cocina'),
('Fernando Gonzalez', 'Repartidor', 'Logística', 4, 'Mensajero'),

-- Sucursal 5
('Patricia Rojas', 'Cajero', 'Ventas', 5, 'Vendedor'),
('Ricardo Alvarez', 'Cocinero', 'Cocina', 5, 'Cocina'),
('Monica Chavez', 'Gerente', 'Administración', 5, 'Administrador'),

-- Sucursal 6
('Ana Estrada', 'Cajero', 'Ventas', 6, 'Vendedor'),
('Roberto Vega', 'Cocinero', 'Cocina', 6, 'Cocina'),
('Carolina Vargas', 'Repartidor', 'Logística', 6, 'Mensajero'),

-- Sucursal 7
('Adrian Gomez', 'Cajero', 'Ventas', 7, 'Vendedor'),
('Natalia Ramirez', 'Cocinero', 'Cocina', 7, 'Cocina'),
('Victor Santos', 'Gerente', 'Administración', 7, 'Administrador'),

-- Sucursal 8
('Gabriela Morales', 'Cajero', 'Ventas', 8, 'Vendedor'),
('Andres Herrera', 'Cocinero', 'Cocina', 8, 'Cocina'),
('Felipe Torres', 'Repartidor', 'Logística', 8, 'Mensajero'),

-- Sucursal 9
('Rosa Diaz', 'Cajero', 'Ventas', 9, 'Vendedor'),
('Julio Navarro', 'Cocinero', 'Cocina', 9, 'Cocina'),
('Paula Jimenez', 'Gerente', 'Administración', 9, 'Administrador'),

-- Sucursal 10
('Mario Perez', 'Cajero', 'Ventas', 10, 'Vendedor'),
('Sara Flores', 'Cocinero', 'Cocina', 10, 'Cocina'),
('Emilio Vargas', 'Repartidor', 'Logística', 10, 'Mensajero'),


--5. Ordenes
INSERT INTO Ordenes.Ordenes (IdCliente, IdEmpleados, IdSucursal, IdMensajero, IdPago, IdOrigen, HorarioVenta, TotalCompra, KilometrosRecorrer, FechaDespacho, FechaEntrega, FechaOrdenTomada, FechaOrdenLista) 
VALUES
(2, 4, 2, 1, 1, 1, 'Mañana', 890.00, 7.5, '2023-11-01 08:30:00', '2023-11-01 09:00:00', '2023-11-01 08:00:00', '2023-11-01 09:30:00'),  
(3, 5, 3, 2, 2, 2, 'Tarde', 975.00, 12.0, '2023-11-02 14:00:00', '2023-11-02 15:00:00', '2023-11-02 13:30:00', '2023-11-02 15:30:00'), 
(4, 6, 4, 3, 3, 3, 'Noche', 1050.00, 5.0, '2023-11-03 20:00:00', '2023-11-03 21:00:00', '2023-11-03 19:30:00', '2023-11-03 21:30:00'), 
(5, 7, 5, 4, 1, 1, 'Mañana', 1125.00, 8.0, '2023-11-04 08:30:00', '2023-11-04 09:30:00', '2023-11-04 08:00:00', '2023-11-04 10:00:00'), 
(6, 8, 6, 5, 2, 2, 'Tarde', 1175.00, 10.0, '2023-11-05 14:00:00', '2023-11-05 15:30:00', '2023-11-05 13:30:00', '2023-11-05 16:00:00'), 
(7, 9, 7, 6, 3, 3, 'Noche', 1200.00, 4.5, '2023-11-06 20:30:00', '2023-11-06 21:30:00', '2023-11-06 20:00:00', '2023-11-06 22:00:00') 


