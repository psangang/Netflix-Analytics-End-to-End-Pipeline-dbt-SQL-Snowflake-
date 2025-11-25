{{
  config(
    materialized = 'table',
    )
}}

with fct_ratings as (

    select *
    from {{ ref('fct_ratings') }}

),
seed_data as (

    select *
    from {{ ref('seed_movie_release_dates') }}

)

select
    fr.*,
    case 
        when sd.release_date is null then 'Unknown'
        else 'Known'
    end as release_year_status
from fct_ratings fr
left join seed_data sd
    on fr.movie_id = sd.movie_id   


