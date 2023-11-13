
with partsupp as (
    select *
    from {{ ref('stg_partsupp') }}
)select * from partsupp