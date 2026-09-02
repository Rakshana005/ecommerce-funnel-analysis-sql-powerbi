CREATE DATABASE FunnelAnalysis;

USE FunnelAnalysis;

SELECT * FROM [dbo].[user_events];


-- define sales funnel and the different stages

WITH funnel_stages AS (

    SELECT 
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase
    FROM [dbo].[user_events]
)

SELECT * FROM funnel_stages;


-- conversion rate through the funnel

WITH funnel_stages AS (

    SELECT 
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase
    FROM [dbo].[user_events]
)

SELECT 
    stage_1_views,
    stage_2_cart,
    CAST(ROUND(stage_2_cart * 100.0 / NULLIF(stage_1_views, 0), 2) AS DECIMAL(10,2)) AS view_to_cart_rate,

    stage_3_checkout,
    CAST(ROUND(stage_3_checkout * 100.0 / NULLIF(stage_2_cart, 0), 2) AS DECIMAL(10,2)) AS cart_to_checkout_rate,

    stage_4_payment,
    CAST(ROUND(stage_4_payment * 100.0 / NULLIF(stage_3_checkout, 0), 2) AS DECIMAL(10,2)) AS checkout_to_payment_rate,

    stage_5_purchase,
    CAST(ROUND(stage_5_purchase * 100.0 / NULLIF(stage_4_payment, 0), 2) AS DECIMAL(10,2)) AS payment_to_purchase_rate,

    CAST(ROUND(stage_5_purchase * 100.0 / NULLIF(stage_1_views, 0), 2) AS DECIMAL(10,2)) AS overall_conversion_rate

FROM funnel_stages;


-- funnel by source

WITH source_funnel AS (

    SELECT
        traffic_source,
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS purchases
    FROM [dbo].[user_events]
    GROUP BY traffic_source

)

SELECT 
    traffic_source,
    views,
    carts,
    purchases,
    CAST(ROUND(carts * 100.0 / NULLIF(views, 0), 2) AS DECIMAL(10,2)) AS cart_conversion_rate,
    CAST(ROUND(purchases * 100.0 / NULLIF(views, 0), 2) AS DECIMAL(10,2)) AS purchase_conversion_rate,
    CAST(ROUND(purchases * 100.0 / NULLIF(carts, 0), 2) AS DECIMAL(10,2)) AS cart_to_purchase_conversion_rate
FROM source_funnel
ORDER BY purchases DESC;


-- Time to conversion analysis

WITH user_journey AS (

    SELECT
        user_id,
        MIN(CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
        MIN(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
        MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
    FROM [dbo].[user_events]
    GROUP BY user_id
    HAVING MIN(CASE WHEN event_type = 'purchase' THEN event_date END) IS NOT NULL

)

SELECT 
    COUNT(*) AS converted_users,
    CAST(AVG(CAST(DATEDIFF(MINUTE, view_time, cart_time) AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS avg_view_to_cart_minutes,
    CAST(AVG(CAST(DATEDIFF(MINUTE, cart_time, purchase_time) AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS avg_cart_to_purchase_minutes,
    CAST(AVG(CAST(DATEDIFF(MINUTE, view_time, purchase_time) AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS avg_total_jouney_minutes
FROM user_journey;


-- revenue funnel analysis

WITH funnel_revenue AS (

    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS total_visitors,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS total_buyers,
        CAST(ROUND(SUM(CASE WHEN event_type = 'purchase' THEN amount END), 2) AS DECIMAL(18,2)) AS total_revenue,
        COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS total_orders
    FROM [dbo].[user_events]

)

SELECT
    total_visitors,
    total_buyers,
    total_orders,
    CAST(total_revenue AS DECIMAL(18,2)) AS total_revenue,
    CAST(ROUND(total_revenue / NULLIF(total_orders, 0), 2) AS DECIMAL(18,2)) AS average_order_value,
    CAST(ROUND(total_revenue / NULLIF(total_buyers, 0), 2) AS DECIMAL(18,2)) AS revenue_per_buyer,
    CAST(ROUND(total_revenue / NULLIF(total_visitors, 0), 2) AS DECIMAL(18,2)) AS revenue_per_visitor
FROM funnel_revenue;





