with src_tags as (

    select * from {{ ref('src_tags') }}

)

select
    INITCAP(trim(tag)) as tag_name
from src_tags