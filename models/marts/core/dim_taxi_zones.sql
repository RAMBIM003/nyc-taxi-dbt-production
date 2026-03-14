{{ config(materialized='table') }}

with staging as (
    select * from {{ ref('stg_taxi_zones') }}
)

select
    location_id,
    borough_name,
    zone_name,
    service_zone_type
from staging