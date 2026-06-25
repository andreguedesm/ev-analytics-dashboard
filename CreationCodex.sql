-- 1. Criar base de dados

CREATE DATABASE EV_Analytics;
GO

USE EV_Analytics;
GO


-- 2. Criar tabela final de trips

CREATE TABLE trip_reports_raw (
    trip_id INT IDENTITY(1,1) PRIMARY KEY,
    charging_date DATE,
    distance_km DECIMAL(10,2),
    avg_consumption_kwh_100km DECIMAL(10,2),
    energy_saved DECIMAL(10,2),
    efficiency DECIMAL(10,2),
    average_speed DECIMAL(10,2)
);
GO


-- 3. Criar tabela de parâmetros

CREATE TABLE parameters (
    parameter_name VARCHAR(100),
    parameter_value DECIMAL(10,4)
);
GO


-- 4. Importar parâmetros a partir do CSV

BULK INSERT parameters
FROM 'C:\EV_Analytics\parameters.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n'
);
GO


-- 5. Criar tabela stage para trips

CREATE TABLE trip_reports_stage (
    charging_date VARCHAR(20),
    distance_km DECIMAL(10,2),
    avg_consumption_kwh_100km DECIMAL(10,2),
    energy_saved DECIMAL(10,2),
    efficiency DECIMAL(10,2),
    average_speed DECIMAL(10,2)
);
GO


-- 6. Importar trips para a stage

BULK INSERT trip_reports_stage
FROM 'C:\EV_Analytics\trip_reports_raw.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n'
);
GO


-- 7. Passar dados da stage para a tabela final

INSERT INTO trip_reports_raw (
    charging_date,
    distance_km,
    avg_consumption_kwh_100km,
    energy_saved,
    efficiency,
    average_speed
)
SELECT
    CONVERT(DATE, charging_date, 103),
    distance_km,
    avg_consumption_kwh_100km,
    energy_saved,
    efficiency,
    average_speed
FROM trip_reports_stage;
GO


-- 8. Criar a view enriquecida

CREATE VIEW trip_reports_enriched AS
SELECT 
    t.charging_date,
    t.distance_km,
    t.avg_consumption_kwh_100km,
    ((p_battery.parameter_value * p_soh.parameter_value) 
        / t.avg_consumption_kwh_100km) * 100 AS estimated_range_km,
    (t.avg_consumption_kwh_100km * t.distance_km) / 100 AS total_consumption_kwh,
    t.energy_saved,
    t.efficiency,
    ((t.avg_consumption_kwh_100km * t.distance_km) / 100) 
        / (p_battery.parameter_value * p_soh.parameter_value) AS battery_used_pct,
    t.average_speed
FROM trip_reports_raw t
CROSS JOIN parameters p_battery
CROSS JOIN parameters p_soh
WHERE 
    p_battery.parameter_name = 'factory_battery'
    AND p_soh.parameter_name = 'seller_battery_soh_pct';
GO


-- 9. Criar a dimensão de datas

CREATE TABLE dim_date (
    date_key DATE PRIMARY KEY,
    year INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    weekday_name VARCHAR(20),
    weekday INT
);
GO


-- 10. Preencher a dimensão de datas

WITH dates AS (
    SELECT CAST('2024-01-01' AS DATE) AS d
    UNION ALL
    SELECT DATEADD(DAY, 1, d)
    FROM dates
    WHERE d < '2030-12-31'
)
INSERT INTO dim_date
SELECT
    d AS date_key,
    YEAR(d) AS year,
    MONTH(d) AS month,
    DATENAME(MONTH, d) AS month_name,
    DAY(d) AS day,
    DATENAME(WEEKDAY, d) AS weekday_name,
    DATEPART(WEEKDAY, d) AS weekday
FROM dates
OPTION (MAXRECURSION 3000);
GO


-- 11. Queries de validação

SELECT * FROM parameters;
SELECT * FROM trip_reports_stage;
SELECT * FROM trip_reports_raw;
SELECT * FROM trip_reports_enriched;
SELECT * FROM dim_date;