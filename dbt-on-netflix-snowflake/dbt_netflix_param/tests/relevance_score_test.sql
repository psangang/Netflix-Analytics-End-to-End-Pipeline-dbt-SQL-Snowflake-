-- This is a SINGULAR test in dbt.
-- Purpose:
-- We want to validate that the "relevance" score from the fct_genome_score model
-- is never negative. In the Business context, a genome relevance score should
-- always be between 0 and 1. Any negative value indicates bad, corrupted, or
-- wrongly processed data.

-- If this query returns ANY rows, the test will FAIL.

select 
    movie_id, 
    tag_id, 
    relevance as relevance_score
from {{ ref('fct_genome_score') }}
-- Check for invalid values where relevance is below zero
where relevance < 0
