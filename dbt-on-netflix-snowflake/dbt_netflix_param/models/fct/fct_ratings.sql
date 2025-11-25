{{
    config(
        materialized='incremental',
        on_schema_change='fail'


    )
}}


        -- on_schema_change='fail' means:
        -- If THIS MODEL'S output schema changes (e.g., you add/remove/rename a column),
        -- dbt will STOP the run and throw an error.
        --
        -- It does NOT fail just because the underlying src_ratings table changed.
        -- It only fails when the final columns in THIS SELECT change compared
        -- to the existing target incremental table.
        

with src_ratings as (

    -- Pull all columns from the source table
    select * from {{ ref('src_ratings') }}

)

select
    user_id,
    movie_id,
    rating,
    rating_timestamp
from src_ratings
where rating is not null

{% if is_incremental() %}

    -- Only bring in rows that have a more recent timestamp
    -- compared to what already exists in the incremental table
    and rating_timestamp > (
        select max(rating_timestamp)
        from {{ this }}
    )

{% endif %}