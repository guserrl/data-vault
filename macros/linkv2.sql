{% macro linkv2(src,h_key,key,line) %}
with stg as (
    select
    {{line}}
    {% for k in h_key%}
    ,{{k}}
    {%endfor%}
    {% for k2 in key%}
    ,{{k2}}
    {%endfor%}
    ,current_timestamp as load_record
    ,source
    from {{ ref(src) }}
)select * from stg

{%endmacro%}