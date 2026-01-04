'''
1. Escribe una consulta que recupere los Vuelos (flights) y su identificador que figuren con status On Time.
'''

SELECT *
FROM flights
WHERE status = 'On Time';

'''
2. Escribe una consulta que extraiga todas las columnas de la tabla bookings y refleje todas las reservas que han supuesto una cantidad total mayor a 1.000.000 (Unidades monetarias).
'''

SELECT *
FROM bookings
WHERE total_amount >= 1000000;

'''
3. Escribe una consulta que extraiga todas las columnas de los datos de los modelos de aviones disponibles (aircraft_data). Puede que os aparezca en alguna actualización como "aircrafts_data", revisad las tablas y elegid la que corresponda.
'''

SELECT model
FROM aircrafts_data;

'''
4. Con el resultado anterior visualizado previamente, escribe una consulta que extraiga los identificadores de vuelo que han volado con un Boeing 737. (Código Modelo Avión = 733)
'''

SELECT *
FROM aircrafts_data
WHERE aircraft_code = '733';

'''
5. Escribe una consulta que te muestre la información detallada de los tickets que han comprado las personas que se llaman Irina.
'''

SELECT *
FROM tickets
WHERE passenger_name LIKE 'IRINA%';

'''
6. Mostrar las ciudades con más de un aeropuerto.
'''

SELECT city, COUNT(*) AS aeropuertos_en_la_ciudad
FROM airports_data
GROUP BY city
HAVING COUNT(*) > 1;

'''
7. Mostrar el número de vuelos por modelo de avión.
'''

SELECT model, COUNT(*) AS numero_vuelos
FROM flights
JOIN aircrafts_data ON flights.aircraft_code = aircrafts_data.aircraft_code
GROUP BY model;

'''
8. Reservas con más de un billete (varios pasajeros).
'''

SELECT t.book_ref, t.passenger_name, COUNT(*) OVER (PARTITION BY t.book_ref) AS numero_billetes
FROM tickets t
WHERE t.book_ref IN (
    SELECT book_ref
    FROM tickets
    GROUP BY book_ref
    HAVING COUNT(*) > 1
)
ORDER BY t.book_ref;

'''
9. Vuelos con retraso de salida superior a una hora.
'''

SELECT flight_id, flight_no, scheduled_departure, actual_departure,
       actual_departure - scheduled_departure AS Vuelo_retrasado
FROM flights
WHERE actual_departure - scheduled_departure > INTERVAL '1 hour'
AND actual_departure IS NOT NULL;
