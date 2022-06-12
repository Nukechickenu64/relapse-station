/obj/item/firing_pin
	carry_weight = 100 GRAMS

/obj/item/firing_pin/Initialize()
	. = ..()
	if((. == INITIALIZE_HINT_NORMAL) || (. == INITIALIZE_HINT_LATELOAD))
		AddElement(/datum/element/multitool_emaggable)
