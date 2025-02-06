{% test validate_company_state(model) %}

WITH company_expected_states AS (
    SELECT * FROM (VALUES
        ('La Trobe Melbourne', 'VIC'),
        ('La Trobe Sydney', 'NSW'),
        ('Mayer Melbourne', 'VIC')
    ) AS t(company_name, expected_state)
),

validation AS (
    SELECT 
        c.customer_id,
        c.company_name,
        c.state,
        e.expected_state
    FROM {{ model }} AS c
    LEFT JOIN company_expected_states AS e
    ON c.company_name = e.company_name
),

validation_errors AS (
    SELECT 
        customer_id,
        company_name,
        state,
        expected_state
    FROM validation
    WHERE state <> expected_state  -- Check if the state is incorrect
)

SELECT * FROM validation_errors

{% endtest %}
