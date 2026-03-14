with dim_zones as (
    select * from {{ ref('dim_taxi_zones') }}
)

select
    borough_name,
    count(location_id) as total_zones
from dim_zones
group by 1
order by 2 desc