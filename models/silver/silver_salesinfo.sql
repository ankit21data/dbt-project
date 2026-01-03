WITH sales_data AS (
    SELECT 
    sales_id, 
    product_sk,
    customer_sk,
    gross_amount
     FROM {{ ref("bronze_sales") }}
),
final_data AS(
    SELECT 
    p.product_name,
    p.category,
    c.gender,
    SUM(sd.gross_amount) AS total_sales
    FROM sales_data sd
    LEFT JOIN {{ ref("bronze_product") }} p ON sd.product_sk = p.product_sk
    LEFT JOIN {{ ref("bronze_customer") }} c ON sd.customer_sk = c.customer_sk
    GROUP BY 1,2,3
    ORDER BY total_sales DESC
)

SELECT * FROM final_data