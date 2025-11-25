{{
    config(
        materialized='ephemeral'
    )
}}

with movies as (

    select * from {{ ref('dim_movies') }}
), 
scores as (

    select * from {{ ref('fct_genome_score') }}

)

select
    m.movie_id,
    m.movie_title,
    m.genre,
    s.relevance
from movies m
left join scores s
    on m.movie_id = s.movie_id
