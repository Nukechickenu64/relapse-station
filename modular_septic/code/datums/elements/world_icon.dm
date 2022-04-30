/datum/element/world_icon
	id_arg_index = 2
	element_flags = ELEMENT_BESPOKE | ELEMENT_DETACH
	/// Proc used to update the appearance of the object when in the world
	var/attached_proc

/datum/element/world_icon/Attach(atom/target, attached_proc)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE
	src.attached_proc = attached_proc
	RegisterSignal(target, COMSIG_ATOM_UPDATE_ICON, .proc/update_icon)
	RegisterSignal(target, list(COMSIG_ITEM_EQUIPPED, COMSIG_STORAGE_ENTERED, COMSIG_ITEM_DROPPED, COMSIG_STORAGE_EXITED), .proc/inventory_updated)
	target.update_appearance()

/datum/element/world_icon/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ATOM_UPDATE_ICON)
	UnregisterSignal(source, list(COMSIG_ITEM_EQUIPPED, COMSIG_STORAGE_ENTERED, COMSIG_ITEM_DROPPED, COMSIG_STORAGE_EXITED))

/datum/element/world_icon/proc/update_icon(obj/item/source, updates)
	SIGNAL_HANDLER

	if(source.item_flags & IN_INVENTORY)
		return

	if(attached_proc)
		return call(source, attached_proc)()

/datum/element/world_icon/proc/inventory_updated(obj/item/source)
	SIGNAL_HANDLER

	source.update_icon()
