/datum/element/weapon_description/warning_label(obj/item/item, mob/user, list/examine_texts)
	SIGNAL_HANDLER

	examine_texts += span_notice("<a href='?src=[REF(item)];examine=1'>Inspect Offense</a>")
