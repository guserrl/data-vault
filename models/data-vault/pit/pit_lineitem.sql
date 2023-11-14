with hub as (
    select 
    l_line_item_haskey
    ,load_record
    from {{ ref('l_line_item') }}
)
, pit as (
    select 
    h.l_line_item_haskey as l_line_item_haskey
    ,current_timestamp as pit_load_record
    ,h.load_record as line_item_load_record
    ,recipt.load_record as recipt_load_record
    ,ship.load_record as ship_load_record
    ,status.load_record as status_load_record
    from  hub h join {{ ref('s_lineitem_receipt') }} recipt on recipt.l_line_item_haskey=h.l_line_item_haskey and recipt.is_active=1
    join {{ ref('s_lineitem_ship') }} ship on ship.l_line_item_haskey=h.l_line_item_haskey and ship.is_active=1
    join {{ ref('s_lineitem_status') }} status on status.l_line_item_haskey=h.l_line_item_haskey and status.is_active=1
)select * from pit