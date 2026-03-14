with source as (

    select * from {{ source('seed_data', 'taxi_zone_lookup') }}
),

renamed as (
    select
        
        cast("LocationID" as integer) as location_id,
        {{ clean_string('"Borough"') }} as borough_name,
        {{ clean_string('"Zone"') }} as zone_name,
        replace("service_zone", 'Boro', 'Borough') as service_zone_type
    from source
)

select * from renamed
