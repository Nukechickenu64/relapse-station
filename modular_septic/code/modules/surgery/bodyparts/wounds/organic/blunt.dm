
/*
	Blunt/Bone wounds
*/
/datum/wound/blunt
	name = "Blunt Wound"
	sound_effect = list('modular_septic/sound/gore/nasty1.wav', 'modular_septic/sound/gore/nasty2.wav')
	base_treat_time = 6 SECONDS

	wound_type = WOUND_BLUNT
	wound_flags = (WOUND_SOUND_HINTS|WOUND_MANGLES_BONE)

/*
	Moderate - Joint dislocation
*/
/datum/wound/blunt/moderate
	name = "Joint Dislocation"
	desc = "Patient's bone has been unset from socket, causing pain and reduced motor function."
	treat_text = "Recommended application of bonesetter to affected limb, though manual relocation by applying an aggressive grab to the patient and helpfully interacting with afflicted limb may suffice."
	examine_desc = "is awkwardly jammed out of place"
	occur_text = "jerks violently and becomes unseated"

	severity = WOUND_SEVERITY_MODERATE
	viable_zones = ALL_BODYPARTS
	threshold_minimum = 30
	wound_flags = (WOUND_SOUND_HINTS)

/datum/wound/blunt/moderate/apply_wound(obj/item/bodypart/new_limb, silent = FALSE, datum/wound/old_wound = null, smited = FALSE, add_descriptive = TRUE)
	. = ..()
	if(!.)
		return
	var/obj/item/organ/bone/bone
	for(var/thing in shuffle(new_limb.getorganslotlist(ORGAN_SLOT_BONE)))
		var/obj/item/organ/bone/possible_bone = thing
		if(possible_bone.damage >= possible_bone.low_threshold)
			continue
		bone = possible_bone
		break
	if(bone)
		bone.dislocate()
	var/final_descriptive = "A bone is dislocated!"
	// Mandible is pretty significant
	if(istype(bone, BONE_MOUTH))
		final_descriptive = "\The [bone.joint_name] is dislocated!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_danger(" [final_descriptive]"))
	qdel(src)

/*
	Severe (Hairline Fracture)
*/
/datum/wound/blunt/severe
	name = "Hairline Fracture"
	desc = "Patient's bone has suffered a crack in the foundation, causing serious pain and reduced limb functionality."
	treat_text = "Recommended light surgical application of bone gel, though a sling of medical gauze will prevent worsening situation."
	examine_desc = "appears grotesquely swollen, its attachment weakened"
	occur_text = "sprays chips of bone and develops a nasty looking bruise"

	severity = WOUND_SEVERITY_SEVERE
	sound_effect = 'modular_septic/sound/gore/crack2.ogg'
	threshold_minimum = 70
	wound_flags = (WOUND_SOUND_HINTS|WOUND_MANGLES_BONE)

/datum/wound/blunt/severe/apply_wound(obj/item/bodypart/new_limb, silent, datum/wound/old_wound, smited, add_descriptive)
	. = ..()
	if(!.)
		return
	var/obj/item/organ/bone/bone
	for(var/thing in shuffle(new_limb.getorganslotlist(ORGAN_SLOT_BONE)))
		var/obj/item/organ/bone/possible_bone = thing
		if(possible_bone.damage >= possible_bone.medium_threshold)
			continue
		bone = possible_bone
		break
	if(bone)
		bone.fracture()
	var/final_descriptive = "A bone is fractured!"
	// Skull, ribcage and pelvis are pretty significant
	if(istype(bone, BONE_HEAD) || istype(bone, BONE_GROIN) || istype(bone, BONE_CHEST))
		final_descriptive = "\The [bone] is fractured!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [final_descriptive]"))
	qdel(src)

/// Compound Fracture (Critical Blunt)
/datum/wound/blunt/critical
	name = "Compound Fracture"
	desc = "Patient's bones have suffered multiple gruesome fractures, causing significant pain and near uselessness of limb."
	treat_text = "Immediate binding of affected limb, followed by surgical intervention ASAP."
	examine_desc = "is mangled and pulped, seemingly held together by tissue alone"
	occur_text = "cracks apart, exposing broken bones to open air"

	severity = WOUND_SEVERITY_CRITICAL
	sound_effect = 'modular_septic/sound/gore/crack3.ogg'
	threshold_minimum = 100
	wound_flags = (WOUND_SOUND_HINTS|WOUND_MANGLES_BONE)

/datum/wound/blunt/critical/apply_wound(obj/item/bodypart/new_limb, silent, datum/wound/old_wound, smited, add_descriptive)
	. = ..()
	if(!.)
		return
	var/obj/item/organ/bone/bone
	for(var/thing in shuffle(new_limb.getorganslotlist(ORGAN_SLOT_BONE)))
		var/obj/item/organ/bone/possible_bone = thing
		if(possible_bone.damage >= possible_bone.high_threshold)
			continue
		bone = possible_bone
		break
	if(bone)
		bone.compound_fracture()
	var/final_descriptive = "A bone is shattered!"
	// Skull, ribcage and pelvis are pretty significant
	if(istype(bone, BONE_HEAD) || istype(bone, BONE_GROIN) || istype(bone, BONE_CHEST))
		final_descriptive = "\The [bone] is shattered!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [final_descriptive]"))
	qdel(src)

/// Compound Fracture (Critical Blunt)
/datum/wound/blunt/critical
	name = "Compound Fracture"
	desc = "Patient's bones have suffered multiple gruesome fractures, causing significant pain and near uselessness of limb."
	treat_text = "Immediate binding of affected limb, followed by surgical intervention ASAP."
	examine_desc = "is mangled and pulped, seemingly held together by tissue alone"
	occur_text = "cracks apart, exposing broken bones to open air"

	severity = WOUND_SEVERITY_CRITICAL
	sound_effect = 'modular_septic/sound/gore/crack3.ogg'
	threshold_minimum = 80
	wound_flags = (WOUND_SOUND_HINTS|WOUND_MANGLES_BONE)

/datum/wound/blunt/critical/apply_wound(obj/item/bodypart/new_limb, silent, datum/wound/old_wound, smited, add_descriptive)
	. = ..()
	if(!.)
		return
	var/obj/item/organ/bone/bone
	for(var/thing in shuffle(new_limb.getorganslotlist(ORGAN_SLOT_BONE)))
		var/obj/item/organ/bone/possible_bone = thing
		if(possible_bone.damage >= possible_bone.high_threshold)
			bone = possible_bone
			break
	var/final_descriptive = "A bone is shattered!"
	// Skull, ribcage and pelvis are pretty significant
	if(istype(bone, BONE_HEAD) || istype(bone, BONE_GROIN) || istype(bone, BONE_CHEST))
		final_descriptive = "\The [bone] is shattered!"
	if(victim)
		if(sound_effect)
			playsound(new_limb.owner, pick(sound_effect), 70 + 20 * severity, TRUE)
		if(add_descriptive)
			SEND_SIGNAL(victim, COMSIG_CARBON_ADD_TO_WOUND_MESSAGE, span_bolddanger(" [final_descriptive]"))
	qdel(src)
