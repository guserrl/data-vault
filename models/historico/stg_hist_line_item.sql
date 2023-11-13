
with lineitem as (
    select *
    from {{ ref('stg_line_item') }}
)select * from lineitem