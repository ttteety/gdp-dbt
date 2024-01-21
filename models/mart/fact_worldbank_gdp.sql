WITH stg_worldbank_gdp AS (
    SELECT * FROM {{ref('stg_worldbank_gdp')}}
)

, country_code AS (
    SELECT * FROM {{ref('country_code')}}
)

, world_gdp AS (
    SELECT 
        gdp.country_value           AS country,
        gdp.year,
        gdp.value                   AS gdp,
        (gdp.value - LAG(gdp.value) OVER w)/LAG(gdp.value) OVER W AS gdp_growth
    FROM stg_worldbank_gdp gdp 
    INNER JOIN country_code cc 
        ON gdp.country_iso_code = cc."alpha-3"
    WHERE gdp.value IS NOT NULL 
    WINDOW w AS (PARTITION BY country_value ORDER BY year)
)

, final AS (
    SELECT 
        country,
        year,
        gdp,
        gdp_growth,
        MIN(gdp_growth) OVER w         AS min_gdp_growth_since_2000,
        MAX(gdp_growth) OVER w         AS max_gdp_growth_since_2000
    FROM world_gdp
    WHERE year >= 2000
    WINDOW w AS (PARTITION BY country ORDER BY year
        ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING)
)

SELECT * 
FROM final 