/datum/element/fireaxe_brittle

/datum/element/fireaxe_brittle/Attach(datum/target)
	. = ..()
	if(!isobj(target)) //we'll do walls one day, obj is fine for now
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_FIREAXE_BRITTLE_BREAK, .proc/do_break)

/datum/element/fireaxe_brittle/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_FIREAXE_BRITTLE_BREAK)

/datum/element/fireaxe_brittle/proc/do_break(obj/source, obj/item/weapon)
	SIGNAL_HANDLER

	source.atom_destruction(MELEE)
