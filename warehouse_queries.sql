SELECT
    f.sku_id,
    c.date,
    COUNT(*) AS daily_velocity,
    COUNT(CASE WHEN t.direction = 'OUT' THEN 1 END) AS outbound_moves,
    COUNT(CASE WHEN t.direction = 'IN' THEN 1 END) AS inbound_moves
FROM dbo.transaction_fact_table AS f
JOIN dbo.transaction_type_dim AS t
    ON f.transaction_type = t.transaction_type
JOIN dbo.full_calendar_dim AS c
    ON f.transaction_date = c.date
GROUP BY
    f.sku_id,
    c.date
ORDER BY
    f.sku_id,
    c.date;