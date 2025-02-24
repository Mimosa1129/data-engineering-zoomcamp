WITH filtered_trips AS (
    SELECT 
        EXTRACT(YEAR FROM tpep_pickup_datetime) AS year,
        EXTRACT(MONTH FROM tpep_pickup_datetime) AS month,
        fare_amount
    FROM `de-zoomcamp-mimosa.de_zoomcamp_dbt.yellow_tripdata`
    WHERE fare_amount > 0 
      AND trip_distance > 0 
      AND payment_type IN (1, 2)  -- 只保留 Cash 和 Credit Card
      and tpep_pickup_datetime>="2019-01-01"
      and tpep_pickup_datetime<"2021-01-01"
),
percentiles AS (
    SELECT 
        year,
        month,
        APPROX_QUANTILES(fare_amount, 100) AS fare_percentiles
    FROM filtered_trips
    GROUP BY year, month
)

SELECT 
    year,
    month,
    fare_percentiles[97] AS fare_p97,
    fare_percentiles[95] AS fare_p95,
    fare_percentiles[90] AS fare_p90
FROM percentiles
where year = 2020 and month = 4;
