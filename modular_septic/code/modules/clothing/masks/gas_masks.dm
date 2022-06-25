/obj/item/clothing/mask/gas
	lowers_pitch = TRUE

///Check _masks.dm for this one
/obj/item/clothing/mask/gas/consume_filter_pollution(datum/pollution/pollution)
	if(LAZYLEN(gas_filters) <= 0 || max_filters == 0)
		return
	var/obj/item/gas_filter/gas_filter = pick(gas_filters)
	gas_filter.reduce_filter_status_pollution(pollution)
	if(gas_filter.filter_status <= 0)
		LAZYREMOVE(gas_filters, gas_filter)
		qdel(gas_filter)
	if(LAZYLEN(gas_filters) <= 0)
		has_filter = FALSE

/obj/item/clothing/mask/gas/idobe
	name = "IDOBE gas mask"
	desc = "A filtered gas-mask manufactured by IDOBE, can be connected to an oxygen supply and/or a filter at the same time. "
	icon_state = "idobe"
	worn_icon_state = "idobe"
	inhand_icon_state = "gas_alt"
	permeability_coefficient = 0.01
	starting_filter_type = /obj/item/gas_filter
