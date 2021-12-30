/obj/machinery/vending/Initialize(mapload)
	. = ..()
	if(InitializeExtraItems())
		build_inventory(products, product_records)
		build_inventory(contraband, hidden_records)
		build_inventory(premium, coin_records)
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)

/obj/machinery/vending/proc/InitializeExtraItems()
	return
