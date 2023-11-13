
-- depends_on: {{ ref('stg_supplier') }}
--parte full
{% if not is_incremental() %}

{{full('stg_hist_supplier','h_supplier_haskey',['suppkey'],['source','name','address','phone','acctbal','comment'])}}

{% else %}

{{s_incremental('stg_supplier',this,'h_supplier_haskey',['suppkey'],['source','name','address','phone','acctbal','comment']) }}

{% endif %}