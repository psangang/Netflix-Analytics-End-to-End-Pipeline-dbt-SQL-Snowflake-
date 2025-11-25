with raw_movies as (
    select *
    from movielens.raw.raw_movies
)
select movieid as movie_id,
       title,
       genre
from raw_movies