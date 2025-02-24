WITH trips_data AS (
    SELECT * FROM `de-zoomcamp-mimosa.de_zoomcamp_dbt.green_tripdata`
    where lpep_pickup_datetime >= "2019-01-01"
    and lpep_pickup_datetime < "2021-01-01"
),
quarterly_revenue AS (
    SELECT 
        EXTRACT(YEAR FROM lpep_pickup_datetime) AS revenue_year,
        EXTRACT(QUARTER FROM lpep_pickup_datetime) AS revenue_quarter,       
        -- Revenue calculation 
        SUM(total_amount) AS revenue_quarterly_total_amount,
    FROM trips_data
    GROUP BY 1,2
),

yoy_growth AS (
    SELECT 
        curr.revenue_year,
        curr.revenue_quarter,
        curr.revenue_quarterly_total_amount,
        prev.revenue_quarterly_total_amount AS prev_revenue,
        
        -- YoY Growth Calculation
        CASE 
            WHEN prev.revenue_quarterly_total_amount IS NOT NULL 
            THEN ((curr.revenue_quarterly_total_amount - prev.revenue_quarterly_total_amount) / prev.revenue_quarterly_total_amount) * 100
            ELSE NULL 
        END AS yoy_growth_percentage
    FROM quarterly_revenue curr
    LEFT JOIN quarterly_revenue prev
    ON curr.revenue_year = prev.revenue_year + 1
    AND curr.revenue_quarter = prev.revenue_quarter
)

SELECT * FROM yoy_growth
ORDER BY revenue_year DESC, revenue_quarter DESC;
