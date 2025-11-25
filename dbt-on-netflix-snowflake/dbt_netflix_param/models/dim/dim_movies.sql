with src_movies as (

    select * from {{ ref('src_movies') }}

)

select
    movie_id,
    initcap(trim(title)) as movie_title,

    -- SPLIT() in Snowflake returns an ARRAY because it is defined as:
    -- SPLIT(string, delimiter) → ARRAY
    -- So SPLIT(genre, '|') produces an ARRAY of strings like ["Action","Comedy"]
    split(genre, '|') as genre_array,

    genre

from src_movies

