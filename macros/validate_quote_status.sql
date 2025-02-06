{% test validate_quote_status(model) %}
WITH validation AS (

    SELECT
        quote_number,
        MAX(CASE WHEN status = 'approved' THEN date END) AS approved_date,
        MAX(CASE WHEN status = 'won' THEN date END) AS won_date

     FROM {{ model }} 
    GROUP BY quote_number

),

validation_errors AS (

    SELECT
        quote_number,
        approved_date,
        won_date
    FROM validation
    WHERE won_date <= approved_date  -- Check if won date is not after approved date

)

SELECT * 
FROM validation_errors
{% endtest %}
