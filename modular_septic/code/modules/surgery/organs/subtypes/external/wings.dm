/obj/item/organ/external/wings
	name = "wings"
	desc = "A pair of wings. Those may or may not allow you to fly... or at the very least flap."
	zone = BODY_ZONE_CHEST
	organ_efficiency = list(ORGAN_SLOT_EXTERNAL_WINGS = 100)
	icon_state = "wings"
	dna_block = DNA_WINGS_BLOCK
	mutantpart_key = "wings"
	mutantpart_colored = TRUE
	mutantpart_info = list(MUTANT_INDEX_NAME = "Bat", MUTANT_INDEX_COLOR = list("335533"))
	///What species get flights thanks to those wings - Important for moth wings
	var/list/flight_for_species
	///Whether the wings should grant flight on insertion.
	var/unconditional_flight = FALSE
	///Whether a wing can be opened by the *wing emote. The sprite use a "_open" suffix, before their layer
	var/can_open = FALSE
	///Whether an openable wing is currently opened
	var/is_open = FALSE
	///Whether the owner of wings has flight thanks to the wings
	var/granted_flight = FALSE

///hud action for starting and stopping flight
/datum/action/innate/flight
	name = "Toggle Flight"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_IMMOBILE
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "flight"

/datum/action/innate/flight/Activate()
