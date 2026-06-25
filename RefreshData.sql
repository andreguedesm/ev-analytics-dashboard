USE EV_Analytics;
GO

TRUNCATE TABLE trip_reports_stage;
GO

BULK INSERT trip_reports_stage
FROM 'C:\EV_Analytics\trip_reports_raw.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n'
);
GO

TRUNCATE TABLE trip_reports_raw;
GO

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