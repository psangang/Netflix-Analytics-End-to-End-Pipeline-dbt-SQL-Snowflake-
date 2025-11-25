with fct_moviee_with_tags as (

    select * from {{ ref('dim_movies_with_tags') }}

)   

select * from fct_moviee_with_tags