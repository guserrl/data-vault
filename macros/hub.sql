{%- macro hub(h_key,key,src) -%}
with stg as(
    select 
    {{h_key}}
    ,{{key}}
    ,current_timestamp as load_record
    ,source
    from {{ ref(src) }}
)select * from stg

{%- endmacro -%}