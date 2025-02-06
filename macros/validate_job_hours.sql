{% test validate_job_hours(model) %}

WITH job_thresholds AS (
    SELECT * FROM (VALUES
        ('belt replacement', 11),
        ('repair ac', 15),
        ('replace board', 4)
    ) AS t(job_type, max_hours)
),

validation AS (
    SELECT 
        job_id,
        j.job_type,
        j.hours,
        t.max_hours
    FROM {{ model }} AS j
    LEFT JOIN job_thresholds AS t
    ON j.job_type = t.job_type
),

validation_errors AS (
    SELECT 
        job_id,
        job_type,
        hours,
        max_hours
    FROM validation
    WHERE hours > max_hours  -- Check if hours exceed the threshold
)

SELECT * FROM validation_errors

{% endtest %}
