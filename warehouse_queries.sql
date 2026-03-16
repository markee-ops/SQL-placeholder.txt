/*******************************************************
 QUERY ONE — TOTAL SKU MOVEMENT
*******************************************************/
SELECT 
    sku_id,
    COUNT(*) AS total_movements
FROM fact_movements
GROUP BY sku_id
ORDER BY total_movements DESC;



/*******************************************************
 QUERY TWO — SKU MOVEMENT VELOCITY
*******************************************************/
SELECT 
    sku_id,
    COUNT(*) / COUNT(DISTINCT movement_date) AS movement_velocity
FROM fact_movements
GROUP BY sku_id
ORDER BY movement_velocity DESC;



/*******************************************************
 QUERY THREE — CATEGORY MOVEMENT FLOW
*******************************************************/
SELECT 
    d.category,
    COUNT(f.movement_id) AS total_movements
FROM fact_movements f
JOIN dim_sku d 
    ON f.sku_id = d.sku_id
GROUP BY d.category
ORDER BY total_movements DESC;



/*******************************************************
 QUERY FOUR — ORPHANED TRANSACTION AUDIT
*******************************************************/
SELECT 
    f.movement_id,
    f.sku_id,
    f.handler_id,
    f.movement_date
FROM fact_movements f
LEFT JOIN dim_sku d 
    ON f.sku_id = d.sku_id
WHERE d.sku_id IS NULL;



/*******************************************************
 QUERY FIVE — INVENTORY TURNOVER RATIO
*******************************************************/
SELECT 
    sku_id,
    SUM(CASE WHEN movement_type = 'OUTBOUND' THEN 1 ELSE 0 END) 
        / NULLIF(AVG(on_hand_qty), 0) AS inventory_turnover_ratio
FROM fact_movements
GROUP BY sku_id
ORDER BY inventory_turnover_ratio DESC;



/*******************************************************
 QUERY SIX — WAREHOUSE ZONE MOVEMENT SUMMARY
*******************************************************/
SELECT 
    zone,
    COUNT(*) AS total_movements
FROM fact_movements
GROUP BY zone
ORDER BY total_movements DESC;



/*******************************************************
 QUERY SEVEN — DAILY HANDLER PRODUCTIVITY REPORT
*******************************************************/
SELECT 
    handler_id,
    movement_date,
    COUNT(*) AS daily_units_processed
FROM fact_movements
GROUP BY handler_id, movement_date
ORDER BY movement_date, daily_units_processed DESC;



/*******************************************************
 QUERY EIGHT — HANDLER PRODUCTIVITY BY SKU
*******************************************************/
SELECT 
    handler_id,
    sku_id,
    COUNT(*) AS units_processed
FROM fact_movements
GROUP BY handler_id, sku_id
ORDER BY handler_id, units_processed DESC;



/*******************************************************
 QUERY NINE — AVERAGE DAILY MOVEMENTS PER HANDLER
*******************************************************/
SELECT 
    handler_id,
    AVG(daily_count) AS avg_daily_movements
FROM (
    SELECT 
        handler_id,
        movement_date,
        COUNT(*) AS daily_count
    FROM fact_movements
    GROUP BY handler_id, movement_date
) x
GROUP BY handler_id
ORDER BY avg_daily_movements DESC;



/*******************************************************
 QUERY TEN — DAILY MOVEMENT COUNT
*******************************************************/
SELECT 
    movement_date,
    COUNT(*) AS total_daily_movements
FROM fact_movements
GROUP BY movement_date
ORDER BY movement_date;
