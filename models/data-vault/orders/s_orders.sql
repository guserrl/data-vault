
 -- depends_on: {{ ref('stg_orders') }}
--parte full
{% if not is_incremental() %}

{{full('stg_hist_orders','h_order_haskey',['orderkey'],['source','orderstatus','totalprice','orderdate','orderpriority','clerk','shippriority','comment'])}}
 
{% else %}

{{s_incremental('stg_orders',this,'h_order_haskey',['orderkey'],['source','orderstatus','totalprice','orderdate','orderpriority','clerk','shippriority','comment']) }}

{% endif %}
