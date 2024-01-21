WITH source AS (
    SELECT * FROM {{ source('worldbank', 'worldbank_gdp')}}
)

SELECT 
    countryiso3code     AS country_iso_code,
    date::integer       AS year,
    value,
    unit,
    obs_status,
    decimal,
    "indicator.id"      AS indicator_id,
    "indicator.value"   AS indicator_value,
    "country.id"        AS country_id,
    "country.value"     AS country_value
FROM source 