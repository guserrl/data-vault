-- depends_on: {{ ref('stg_customer') }}
--parte full
{% if not is_incremental() %}

{{full('stg_hist_customer','h_customer_haskey',['custkey'],['source','name','address','phone','acctbal','mktsegment','comment','nationkey'])}}

{% else %}

{{s_incremental('stg_customer',this,'h_customer_haskey',['custkey'],['source','name','address','phone','acctbal','mktsegment','comment','nationkey']) }}

{% endif %}



