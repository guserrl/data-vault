
-- depends_on: {{ ref('stg_line_item') }}
{% if not is_incremental() %}

{{fullv2('stg_hist_line_item','l_line_item_haskey',['orderkey','partkey','suppkey'],['source','shipdate','shipinstruct','shipmode','returnflag'],'has_diff_ship')}}

{% else %}

{{s_incrementalv3('stg_line_item',this,'l_line_item_haskey',['orderkey','partkey','suppkey'],['source','shipdate','shipinstruct','shipmode','returnflag'],'has_diff_ship') }}

{% endif %}