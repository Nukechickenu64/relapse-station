//SS13 ones seem to be on the heavier side of defibs
/obj/item/defibrillator
	carry_weight = 4 KILOGRAMS

/obj/item/defibrillator/Initialize()
	. = ..()
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)

/obj/item/defibrillator/compact
	carry_weight = 3 KILOGRAMS
