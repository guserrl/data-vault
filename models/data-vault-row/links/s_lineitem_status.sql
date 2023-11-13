
-- depends_on: {{ ref('stg_line_item') }}
{% if not is_incremental() %}

{{fullv2('stg_hist_line_item','l_line_item_haskey',['orderkey','partkey','suppkey'],['source','linenumber','commitdate','linestatus','comment'],'has_diff_status')}}

{% else %}
--Si quieres que no aparezcan las keys en el sat o no aparezcan algunas, solo es dejar vacia la lista
{{s_incrementalv3('stg_line_item',this,'l_line_item_haskey',['orderkey','partkey','suppkey'],['source','linenumber','commitdate','linestatus','comment'],'has_diff_status') }}

{% endif %}