/obj/item/storage
	var/tetris = FALSE
	var/storage_flags = NONE

/obj/item/storage/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		STR.tetris = tetris
		STR.storage_flags = storage_flags
	update_tetris_inventory()

/obj/item/storage/proc/update_tetris_inventory()
	//this is stupid shitcode but tetris inventory sadly requires it
	var/drop_location = drop_location()
	for(var/obj/item/item_in_source in contents)
		if(drop_location)
			item_in_source.forceMove(drop_location)
		else
			item_in_source.moveToNullspace()
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, item_in_source, null, TRUE, FALSE, FALSE)
