
with part as (
select *
from {{ ref('stg_part')}}
)select * from part