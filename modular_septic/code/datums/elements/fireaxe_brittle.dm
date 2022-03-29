/datum/element/fireaxe_brittle
	element_flags = ELEMENT_DETACH

/datum/element/fireaxe_brittle/Attach(datum/target)
	. = ..()
	var/atom/atom_target = target
	if(!istype(atom_target) || !atom_target.uses_integrity || isarea(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_FIREAXE_BRITTLE_BREAK, .proc/do_break)

/datum/element/fireaxe_brittle/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_FIREAXE_BRITTLE_BREAK)

/datum/element/fireaxe_brittle/proc/do_break(obj/source, obj/item/weapon)
	SIGNAL_HANDLER

	source.atom_destruction(MELEE)
