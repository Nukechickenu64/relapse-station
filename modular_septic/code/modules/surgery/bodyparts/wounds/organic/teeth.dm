/*
	Britification
*/
/datum/wound/teeth
	name = "Dental Avulsion"
	desc = "Patient's teeth have been violently ripped off due to blunt trauma."
	occur_text = "has it's teeth sail off in an arc"
	sound_effect = list('modular_septic/sound/gore/trauma1.ogg', \
					'modular_septic/sound/gore/trauma2.ogg', \
					'modular_septic/sound/gore/trauma3.ogg')

	severity = WOUND_SEVERITY_TRIVIAL
	viable_zones = ALL_BODYPARTS

	threshold_minimum = 20
	wound_type = WOUND_TEETH
	wound_flags = (WOUND_SOUND_HINTS)

/datum/wound/teeth/can_afflict(obj/item/bodypart/new_limb, datum/wound/old_wound)
	. = ..()
	if(!.)
		return
	if(!new_limb.get_teeth_amount())
		return FALSE

/datum/wound/teeth/apply_wound(obj/item/bodypart/new_limb, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, add_descriptive = TRUE)
	. = ..()
	if(!.)
		return
	if(!new_limb.max_teeth)
		qdel(src)
		return
	var/final_descriptive = "Teeth sail off in an arc!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [final_descriptive]"))
	new_limb.knock_out_teeth(rand(1,4))
	qdel(src)
