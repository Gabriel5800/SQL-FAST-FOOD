CREATE DATABASE Fast_Food
ON 
( NAME = 'Fast_Food',
  FILENAME = 'C:\SQL2024\Fast_Food.mdf')

  Use Fast_Food
 -- Crear Schema Por tablas
 Create Schema Mensajero
 Create Schema Empleados
 Create Schema Sucursal
 Create Schema Productos
 Create Schema Categoria
 Create Schema Cliente
 Create Schema TipoPago
 Create Schema Detalle
 Create Schema Origen
 Create Schema Ordenes

--Creación de tablas

Create Table Mensajero.Mensajero (
IdMensajero int identity (1,1)NOT NULL Primary key,
Nombre varchar (100),
EsExterno BIT )


CREATE TABLE Empleados.Empleados (
IdEmpleados int identity (1,1)NOT NULL Primary key,
Nombre varchar (100),
Posicion varchar (100) ,
Departamento varchar (100) ,
IdSucursal int Foreign key (IdSucursal) REFERENCES Sucursal.Sucursal(IdSucursal),
Rol Varchar (100))

CREATE TABLE Sucursal.Sucursal (
IdSucursal int identity (1,1) NOT NULL Primary key,
Sucursal varchar (100),
Direccion Varchar(200),
)

CREATE TABLE Productos.Productos (
IdProductos int identity (1,1) NOT NULL Primary key,
Productos varchar (100) ,
IdCategoria Int Foreign key (Idcategoria) REFERENCES Categoria.Categoria(IdCategoria),
Precio DECIMAL )

CREATE TABLE Categoria.Categoria (
IdCategoria int identity (1,1) NOT NULL Primary key,
Categoria varchar (100))

CREATE TABLE Cliente.Cliente (
IdCliente int identity (1,1) NOT NULL Primary key,
Nombre varchar (100) ,
Direccion varchar (200) )

CREATE TABLE TipoPago.TipoPago (
IdPago int identity (1,1) NOT NULL Primary key,
Descripcion Varchar (100))

CREATE TABLE Detalle.Detalle (
IdDetalle int identity (1,1) NOT NULL Primary key, 
IdOrden Int Foreign key (IdOrden) REFERENCES Ordenes.Ordenes (IdOrden),
IdProductos Int Foreign key (Idproductos) REFERENCES Productos.Productos(Idproductos),
Cantidad Int,
Precio Decimal)

CREATE TABLE Origen.Origen (
IdOrigen int identity (1,1) NOT NULL Primary key, 
Descripcion varchar (100))


CREATE TABLE Ordenes.Ordenes (
IdOrden int identity (1,1) Primary key, 
IdEmpleados int Foreign key (IdEmpleados) REFERENCES Empleados.Empleados (IdEmpleados),
IdSucursal int Foreign key (IdSucursal) REFERENCES Sucursal.Sucursal(IdSucursal),
IdMensajero int Foreign key (IdMensajero) REFERENCES Mensajero.Mensajero(IdMensajero),
IdCliente int Foreign key (IdCliente) REFERENCES Cliente.Cliente(IdCliente),
IdOrigen int Foreign key (IdOrigen) REFERENCES Origen.Origen(IdOrigen),
IDPago int Foreign key (IdPago) REFERENCES TipoPago.TipoPago(IdPago),
HorarioVenta Varchar(100)NOT NULL,
TotalCompra  Decimal NOT NULL,
KilometrosRecorrer Decimal NOT NULL,
FechaDespacho Datetime NOT NULL,
FechaEntrega Datetime NOT NULL,
FechaOrdenTomada Datetime NOT NULL,
FechaOrdenLista Datetime NOT NULL,)


