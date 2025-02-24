AVANCE 3
Use Fast_Food

--¿Cuál es el total de ventas (TotalCompra) a nivel global?

SELECT SUM(TotalCompra) AS VentasTotales
FROM Ordenes.Ordenes;

--¿Cuál es el precio promedio de los productos dentro de cada categoría?
Select IdCategoria, AVG(Precio) AS [Promedio Precios]
From Productos.Productos
Group BY IDCategoria


--¿Cuál es el valor de la orden mínima y máxima por cada sucrusal?

Select IdSucursal,
		Min(TotalCompra)AS Minimo,
		Max(TotalCompra)AS Maximo
From Ordenes.Ordenes
Group By IdSucursal

--¿Cuál es el mayor número de kilómetros para una entrega?
Select MAX(KilometrosRecorrer) as [Máximos de kilómetros recorridos]
From Ordenes.Ordenes

--¿Cuál es la cantidad promedio de productos por orden?
Select* From Detalle.Detalle; 
Select IdOrden, AVG(Cantidad) AS CantidadPromedio
From Detalle.Detalle
Group BY IdOrden;

--¿Cómo se distribuye la facturación total del negocio de acuerdo a los métodos de pago?
Select* From Ordenes.Ordenes
Select IdPago, SUM(TotalCompra) AS TotalFacturacion
From Ordenes.Ordenes
Group BY IdPago;

Select* From TipoPago.TipoPago

--¿Cuál sucursal tiene el ingreso promedio más alto?
SELECT TOP 1 IdSucursal, AVG(TotalCompra) AS PromedioIngreso
FROM Ordenes.Ordenes
GROUP BY IdSucursal
ORDER BY PromedioIngreso DESC;

--¿Cuáles son las sucursales que han generado ventas totales por encima de $1000?
Select IdSucursal, Sum(TotalCompra) AS TotalVentas
From Ordenes.Ordenes
Group By IdSucursal
Having Sum(TotalCompra) >1000
Order by TotalVentas DESC;

--¿Cómo Se comparan las ventas promedio antes y después del 1 de julio de 2023?
Select 'Antes de 2023-07-01' As Periodo, AVG(TotalCompra) As Promedio
From Ordenes.Ordenes
Where FechaOrdenTomada < '2023-07-01'
Union All
Select 'Despues de 2023-07-01' AS Periodo, Avg(TotalCompra)
From Ordenes.Ordenes
Where FechaOrdenTomada > '2023-07-01';
 
/*¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor		
   cantidad de ventas, cuál es el ingreso promedio de estas ventas, y cuál 
   ha sido el importe máximo alcanzado por una orden en dicha jornada?*/
   Select * From Ordenes.Ordenes;
   Select HorarioVenta,
		COUNT(IdOrden) AS CantidadVenta,
		AVG(TotalCompra) AS IngresoPromedio,
		MAX (TotalCompra) AS ImporteMaximo
   From Ordenes.Ordenes
   Group BY HorarioVenta
   Order BY IngresoPromedio DESC;


--ULTIMAS CONSULTAS JOIN, CASE

/* ¿Cuál es el tiempo promedio desde el despacho hasta la entrega de los pedidos gestionados por todo el equipo de mensajería?*/
Select*From Ordenes.Ordenes

Select AVG(Datediff(Minute,FechaDespacho, FechaEntrega)) AS [Promedio Entrega]
From Ordenes.Ordenes;


/*¿Qué canal de ventas genera más ingresos?*/
Select*From Origen.Origen
Select*From Ordenes.Ordenes

Select 
O.IdOrigen,
O.Descripcion,
Sum(Ord.TotalCompra) As [Total Ingreso]
From Origen.Origen AS O
JOIN Ordenes.Ordenes AS ORD ON ORD.IdOrigen = O.IdOrigen
Group By
O.IdOrigen,
O.Descripcion
Order BY
[Total Ingreso]Desc;


/*¿Cuál es el nivel de ingreso generado por Empleado?*/

Select*From Empleados.Empleados
Select*From Ordenes.Ordenes

Select Ord.IdEmpleados, E.Nombre, Sum(Ord.TotalCompra) As [Total Ingreso]
From Ordenes.Ordenes AS ORD
JOIN Empleados.Empleados AS E ON E.IdEmpleados = Ord.IdEmpleados
Group By 
Ord.IdEmpleados,
E.Nombre
Order by [Total Ingreso] Desc;


/*¿Cómo varía la demanda de productos a lo largo del día? NOTA: Esta consulta no puede ser implementada sin una definición clara 
del horario (mañana, tarde, noche) en la base de datos existente. Asumiremos que HorarioVenta refleja esta información correctamente.*/
Select*From Ordenes.Ordenes
Select*From Detalle.Detalle

Select 
Ord.HorarioVenta, Sum(D.Cantidad) As [Cantidad por Horario]
From Ordenes.Ordenes AS Ord
Join Detalle.Detalle AS D ON Ord.IdOrden = D.IdOrden
Group By 
Ord.HorarioVenta
Order By [Cantidad por Horario]Desc;




/* ¿Cuál es la tendencia de los ingresos generados en cada periodo mensual?*/
Select*From Ordenes.Ordenes

SELECT   Year(FechaOrdenTomada) As Año,  MONTH(FechaOrdenTomada) AS Mes,    SUM(TotalCompra) AS TotalIngresos
FROM     Ordenes.Ordenes
GROUP BY   Year(FechaOrdenTomada), MONTH(FechaOrdenTomada)
ORDER BY   TotalIngresos Desc;



/*¿Qué porcentaje de clientes son recurrentes versus nuevos clientes cada mes? NOTA: La consulta se enfocaría en la frecuencia de órdenes por cliente para inferir la fidelidad.*/
Select*From Ordenes.ordenes
Select*From Cliente.Cliente

Select IdCliente, Count(IdOrden)As Cantidad, Year(FechaordenTomada) As Año, MONTH(FechaOrdenTomada) As Mes
From Ordenes.Ordenes
Group By IdCliente, Year(FechaordenTomada), MONTH(FechaOrdenTomada);

--Solución con IA

WITH ClientePrimeraOrden AS (
    SELECT 
        Idcliente,
        MIN(MONTH(FechaOrdenTomada)) AS MesPrimeraOrden,
        MIN(YEAR(FechaOrdenTomada)) AS AñoPrimeraOrden
    FROM Ordenes.Ordenes
    GROUP BY IdCliente
),
ClientesPorMes AS (
    SELECT
        MONTH(O.FechaOrdenTomada) AS Mes,
        YEAR(O.FechaOrdenTomada) AS Año,
        O.IdCliente,
        CASE 
            WHEN CP.MesPrimeraOrden = MONTH(O.FechaOrdenTomada) 
                AND CP.AñoPrimeraOrden = YEAR(O.FechaOrdenTomada)
            THEN 'Nuevo'
            ELSE 'Recurrente'
        END AS TipoCliente
    FROM Ordenes.Ordenes AS O
    INNER JOIN ClientePrimeraOrden CP
        ON O.IdCliente = CP.IdCliente
)
SELECT 
    Mes,
    Año,
    SUM(CASE WHEN TipoCliente = 'Nuevo' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS [Porcentaje Nuevos],
    SUM(CASE WHEN TipoCliente = 'Recurrente' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS [Porcentaje Recurrentes]
FROM ClientesPorMes
GROUP BY Mes, Año
ORDER BY Año, Mes;








