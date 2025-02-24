AVANCE 3
Use Fast_Food

--�Cu�l es el total de ventas (TotalCompra) a nivel global?

SELECT SUM(TotalCompra) AS VentasTotales
FROM Ordenes.Ordenes;

--�Cu�l es el precio promedio de los productos dentro de cada categor�a?
Select IdCategoria, AVG(Precio) AS [Promedio Precios]
From Productos.Productos
Group BY IDCategoria


--�Cu�l es el valor de la orden m�nima y m�xima por cada sucrusal?

Select IdSucursal,
		Min(TotalCompra)AS Minimo,
		Max(TotalCompra)AS Maximo
From Ordenes.Ordenes
Group By IdSucursal

--�Cu�l es el mayor n�mero de kil�metros para una entrega?
Select MAX(KilometrosRecorrer) as [M�ximos de kil�metros recorridos]
From Ordenes.Ordenes

--�Cu�l es la cantidad promedio de productos por orden?
Select* From Detalle.Detalle; 
Select IdOrden, AVG(Cantidad) AS CantidadPromedio
From Detalle.Detalle
Group BY IdOrden;

--�C�mo se distribuye la facturaci�n total del negocio de acuerdo a los m�todos de pago?
Select* From Ordenes.Ordenes
Select IdPago, SUM(TotalCompra) AS TotalFacturacion
From Ordenes.Ordenes
Group BY IdPago;

Select* From TipoPago.TipoPago

--�Cu�l sucursal tiene el ingreso promedio m�s alto?
SELECT TOP 1 IdSucursal, AVG(TotalCompra) AS PromedioIngreso
FROM Ordenes.Ordenes
GROUP BY IdSucursal
ORDER BY PromedioIngreso DESC;

--�Cu�les son las sucursales que han generado ventas totales por encima de $1000?
Select IdSucursal, Sum(TotalCompra) AS TotalVentas
From Ordenes.Ordenes
Group By IdSucursal
Having Sum(TotalCompra) >1000
Order by TotalVentas DESC;

--�C�mo Se comparan las ventas promedio antes y despu�s del 1 de julio de 2023?
Select 'Antes de 2023-07-01' As Periodo, AVG(TotalCompra) As Promedio
From Ordenes.Ordenes
Where FechaOrdenTomada < '2023-07-01'
Union All
Select 'Despues de 2023-07-01' AS Periodo, Avg(TotalCompra)
From Ordenes.Ordenes
Where FechaOrdenTomada > '2023-07-01';
 
/*�Durante qu� horario del d�a (ma�ana, tarde, noche) se registra la mayor		
   cantidad de ventas, cu�l es el ingreso promedio de estas ventas, y cu�l 
   ha sido el importe m�ximo alcanzado por una orden en dicha jornada?*/
   Select * From Ordenes.Ordenes;
   Select HorarioVenta,
		COUNT(IdOrden) AS CantidadVenta,
		AVG(TotalCompra) AS IngresoPromedio,
		MAX (TotalCompra) AS ImporteMaximo
   From Ordenes.Ordenes
   Group BY HorarioVenta
   Order BY IngresoPromedio DESC;


--ULTIMAS CONSULTAS JOIN, CASE

/* �Cu�l es el tiempo promedio desde el despacho hasta la entrega de los pedidos gestionados por todo el equipo de mensajer�a?*/
Select*From Ordenes.Ordenes

Select AVG(Datediff(Minute,FechaDespacho, FechaEntrega)) AS [Promedio Entrega]
From Ordenes.Ordenes;


/*�Qu� canal de ventas genera m�s ingresos?*/
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


/*�Cu�l es el nivel de ingreso generado por Empleado?*/

Select*From Empleados.Empleados
Select*From Ordenes.Ordenes

Select Ord.IdEmpleados, E.Nombre, Sum(Ord.TotalCompra) As [Total Ingreso]
From Ordenes.Ordenes AS ORD
JOIN Empleados.Empleados AS E ON E.IdEmpleados = Ord.IdEmpleados
Group By 
Ord.IdEmpleados,
E.Nombre
Order by [Total Ingreso] Desc;


/*�C�mo var�a la demanda de productos a lo largo del d�a? NOTA: Esta consulta no puede ser implementada sin una definici�n clara 
del horario (ma�ana, tarde, noche) en la base de datos existente. Asumiremos que HorarioVenta refleja esta informaci�n correctamente.*/
Select*From Ordenes.Ordenes
Select*From Detalle.Detalle

Select 
Ord.HorarioVenta, Sum(D.Cantidad) As [Cantidad por Horario]
From Ordenes.Ordenes AS Ord
Join Detalle.Detalle AS D ON Ord.IdOrden = D.IdOrden
Group By 
Ord.HorarioVenta
Order By [Cantidad por Horario]Desc;




/* �Cu�l es la tendencia de los ingresos generados en cada periodo mensual?*/
Select*From Ordenes.Ordenes

SELECT   Year(FechaOrdenTomada) As A�o,  MONTH(FechaOrdenTomada) AS Mes,    SUM(TotalCompra) AS TotalIngresos
FROM     Ordenes.Ordenes
GROUP BY   Year(FechaOrdenTomada), MONTH(FechaOrdenTomada)
ORDER BY   TotalIngresos Desc;



/*�Qu� porcentaje de clientes son recurrentes versus nuevos clientes cada mes? NOTA: La consulta se enfocar�a en la frecuencia de �rdenes por cliente para inferir la fidelidad.*/
Select*From Ordenes.ordenes
Select*From Cliente.Cliente

Select IdCliente, Count(IdOrden)As Cantidad, Year(FechaordenTomada) As A�o, MONTH(FechaOrdenTomada) As Mes
From Ordenes.Ordenes
Group By IdCliente, Year(FechaordenTomada), MONTH(FechaOrdenTomada);

--Soluci�n con IA

WITH ClientePrimeraOrden AS (
    SELECT 
        Idcliente,
        MIN(MONTH(FechaOrdenTomada)) AS MesPrimeraOrden,
        MIN(YEAR(FechaOrdenTomada)) AS A�oPrimeraOrden
    FROM Ordenes.Ordenes
    GROUP BY IdCliente
),
ClientesPorMes AS (
    SELECT
        MONTH(O.FechaOrdenTomada) AS Mes,
        YEAR(O.FechaOrdenTomada) AS A�o,
        O.IdCliente,
        CASE 
            WHEN CP.MesPrimeraOrden = MONTH(O.FechaOrdenTomada) 
                AND CP.A�oPrimeraOrden = YEAR(O.FechaOrdenTomada)
            THEN 'Nuevo'
            ELSE 'Recurrente'
        END AS TipoCliente
    FROM Ordenes.Ordenes AS O
    INNER JOIN ClientePrimeraOrden CP
        ON O.IdCliente = CP.IdCliente
)
SELECT 
    Mes,
    A�o,
    SUM(CASE WHEN TipoCliente = 'Nuevo' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS [Porcentaje Nuevos],
    SUM(CASE WHEN TipoCliente = 'Recurrente' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS [Porcentaje Recurrentes]
FROM ClientesPorMes
GROUP BY Mes, A�o
ORDER BY A�o, Mes;








