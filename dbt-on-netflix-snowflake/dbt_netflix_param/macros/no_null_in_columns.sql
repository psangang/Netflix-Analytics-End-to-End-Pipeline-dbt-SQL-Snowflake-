{# ==============================================================================
    MACRO NAME: no_nulls_in_cols(model)

    PURPOSE:
    --------
    This macro dynamically identifies all columns in a dbt model/table and
    builds a SQL query that returns any rows where *any* column contains NULL.

    This is usually used as a **generic dbt test**, but it can also be used for
    debugging or validating datasets.

    KEY CONCEPTS TO REMEMBER:
    --------------------------
    1. **Macros cannot run by themselves**
       - You cannot run them directly in Snowflake or VSCode.
       - They only produce SQL when they are *called* by:
            - a model (in /models)
            - a test (in schema.yml)
            - another macro

    2. **dbt macros generate SQL, they do NOT execute SQL**
       - Execution only happens when you run `dbt run` or `dbt test`.

    3. **To verify your logic**, use:  
          - `dbt compile` (recommended)
          - or a temporary debug model (shown below)

    4. **adapter.get_columns_in_relation()**
       - This is the proper dbt 1.9+ way to fetch column metadata.

    HOW THIS MACRO WORKS:
    ----------------------
    - It loops through all columns of the given model
    - It constructs OR conditions like:
          col1 IS NULL OR col2 IS NULL OR col3 IS NULL ...
    - The returned SQL is a complete SELECT statement.

============================================================================== #}

{% macro no_nulls_in_cols(model) %}

    -- Select all rows from the model/table
    select *
    from {{ model }}

    -- Build the WHERE clause to check for NULLs in ANY column
    where
    {% for col in adapter.get_columns_in_relation(model) %}
        {{ col.name }} is null
        {# Add "OR" between conditions, but not after the last one #}
        {% if not loop.last %} or {% endif %}
    {% endfor %}

{% endmacro %}