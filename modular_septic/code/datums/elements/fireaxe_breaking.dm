/datum/element/fireaxe_breaking
	id_arg_index = 2
	element_flags = ELEMENT_BESPOKE
	var/wield_needed = TRUE
	var/proximity_needed = TRUE

/datum/element/fireaxe_breaking/Attach(datum/target, wield_needed = TRUE, proximity_needed = TRUE)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	src.wield_needed = wield_needed
	src.proximity_needed = proximity_needed
	RegisterSignal(target, COMSIG_ITEM_AFTERATTACK, .proc/item_afterattack)

/datum/element/fireaxe_breaking/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_ITEM_AFTERATTACK)

/datum/element/fireaxe_breaking/proc/item_afterattack(obj/item/source, atom/target, mob/user, proximity_flag, click_parameters)
	SIGNAL_HANDLER

	if(wield_needed && !SEND_SIGNAL(source, COMSIG_TWOHANDED_WIELD_CHECK))
		return
	if(!proximity_needed || proximity_flag)
		SEND_SIGNAL(target, COMSIG_FIREAXE_BRITTLE_BREAK, source)
