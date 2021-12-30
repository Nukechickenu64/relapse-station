/obj/item/storage
	var/storage_flags = NONE

/obj/item/storage/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.storage_flags |= storage_flags
