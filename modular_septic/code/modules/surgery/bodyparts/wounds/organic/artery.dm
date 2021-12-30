/datum/wound/artery
	name = "Torn Artery"
	sound_effect = 'modular_septic/sound/gore/artery.ogg'
	base_treat_time = 3 SECONDS
	wound_type = WOUND_ARTERY
	severity = WOUND_SEVERITY_CRITICAL
	desc = "Patient's artery has been violently torn, causing severe hemorrhage."
	treat_text = "Immediate incision of the limb followed by suturing of the torn artery."
	examine_desc = "is <span style='color: #D59998'><i>bleeding profusely</i></span>"
	occur_text = "is violently torn, severing an artery"

	threshold_minimum = 65
	treatable_by = list(/obj/item/stack/medical/suture, /obj/item/stack/medical/nervemend)
	wound_flags = (WOUND_SOUND_HINTS|WOUND_ACCEPTS_STUMP|WOUND_VISIBLE_THROUGH_CLOTHING)

/datum/wound/artery/apply_wound(obj/item/bodypart/new_limb, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, add_descriptive = TRUE)
	. = ..()
	if(!.)
		return
	var/obj/item/organ/artery/artery
	for(var/thing in shuffle(new_limb.getorganslotlist(ORGAN_SLOT_ARTERY)))
		var/obj/item/organ/possible_artery = thing
		if(possible_artery.damage >= possible_artery.maxHealth)
			continue
		artery = possible_artery
		break
	var/dissection = FALSE
	if(artery?.damage >= (artery?.maxHealth * 0.5))
		dissection = TRUE
	if(artery)
		artery.tear()
	var/final_descriptive = "An artery is [dissection ? "torn" : "damaged"]!"
	// Carotid and aorta are pretty significantly dangerous
	if(istype(artery, ARTERY_NECK) || istype(artery, ARTERY_CHEST))
		final_descriptive = "\The [artery] is [dissection ? "dissected" : "damaged"]!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_flashingdanger(" [final_descriptive]"))
	qdel(src)
