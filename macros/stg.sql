
{% macro stg(tabla,src,values,key,prefijo) %}

with 
stg as(
    select 
    md5({{prefijo}}_{{key}}) as h_customer_haskey
    , md5(concat(
        {%- for v in values -%}
           {{prefijo}}_{{v}} {%-if not loop.last -%}, {%-endif-%}
        {%- endfor -%}
    )) as has_diff
    ,{{ dbt_date.now() }} as load_data
    ,'snowflake' as source
    ,{{prefijo}}_{{key}} as {{key}}
    {% for v in values %}
           ,{{prefijo}}_{{v}} as {{v}}
    {% endfor %}
    from {{ source(tabla, src) }}
)select * from stg

{%endmacro%}