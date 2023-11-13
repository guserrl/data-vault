{% macro link(src,h_key,key,h_key2,line) %}

{% set key1 = key[0]  %}
{% set key2 = key[1]  %}

with stg as (
select 
distinct({{h_key}})
,{{key1}}
,{{key2}}
,source
from {{ ref(src) }}
)
, final as (
    select
    md5({{key1}}||{{key2}}) as {{line}}
    ,{{h_key}}
    ,md5({{key2}}) as {{h_key2}}
    ,{{key1}}
    ,{{key2}}
    ,current_timestamp as load_record
    ,source
    from stg
)select * from final


{%endmacro%}