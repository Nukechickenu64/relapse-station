/datum/antagonist/traitor
	name = "Sleeper agent"
	roundend_category = "sleeper agents"
	antagpanel_category = "Sleeper Agent"
	greeting_sound = 'modular_septic/sound/villain/mkultra.wav'
	attribute_sheet = /datum/attribute_holder/sheet/traitor
	var/datum/weakref/cranial_depressurization_implant

/datum/antagonist/traitor/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/datum_owner = mob_override || owner.current
	ADD_TRAIT(datum_owner, TRAIT_NO_ROTTEN_AFTERLIFE, "traitor")
	if(ishuman(mob_override))
		cranial_depressurization_implant = new /obj/item/organ/cyberimp/neck/selfdestruct(mob_override)
		cranial_depressurization_implant = WEAKREF(cranial_depressurization_implant)

/datum/antagonist/traitor/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/datum_owner = mob_override || owner.current
	REMOVE_TRAIT(datum_owner, TRAIT_NO_ROTTEN_AFTERLIFE, "traitor")
	var/obj/item/organ/remove_implant = cranial_depressurization_implant?.resolve()
	if(remove_implant)
		remove_implant.Remove(remove_implant.owner, TRUE)
		qdel(remove_implant)

/datum/antagonist/traitor/on_gain()
	. = ..()
	owner.user.flash_darkness(100)

/datum/antagonist/traitor/Destroy()
	. = ..()
	cranial_depressurization_implant = null
