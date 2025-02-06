{% test validate_company_address(model, column_name) %}

WITH validation AS (
    SELECT 
        {{ column_name }} AS address, 
        CASE 
            WHEN {{ column_name }} ~ '^\d+\/\d+\s[A-Za-z\s]+$' THEN TRUE
            ELSE FALSE
        END AS is_valid
    FROM {{ model }}
)

SELECT address
FROM validation
WHERE is_valid = FALSE

{% endtest %}