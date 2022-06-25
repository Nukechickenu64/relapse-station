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
