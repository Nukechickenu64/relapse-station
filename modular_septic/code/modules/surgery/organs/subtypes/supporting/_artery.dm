/obj/item/organ/artery
	name = "artery"
	desc = "An artery is torn! Literally."
	icon_state = "artery"
	base_icon_state = "artery"

	organ_flags = ORGAN_EDIBLE|ORGAN_LIMB_SUPPORTER|ORGAN_INDESTRUCTIBLE|ORGAN_NO_VIOLENT_DAMAGE
	organ_efficiency = list(ORGAN_SLOT_ARTERY = 100)
	needs_processing = TRUE

	maxHealth = ARTERY_MAX_HEALTH
	high_threshold = ARTERY_MAX_HEALTH * 0.8
	low_threshold = ARTERY_MAX_HEALTH * 0.2
	pain_multiplier = 0.05

	organ_volume = 0.5
	max_blood_storage = 100
	current_blood = 100
	oxygen_req = 0.25
	nutriment_req = 0.15
	hydration_req = 0.15

	/// How much blood we gush when torn
	var/blood_flow = ARTERIAL_BLOOD_FLOW
	/// If torn, this is basically the time until we gush again
	COOLDOWN_DECLARE(next_squirt)
	/// Minimum time until we squirt again
	var/squirt_delay_min_seconds = 4
	/// Maximum time until we squirt again
	var/squirt_delay_max_seconds = 10
	///squirting sound
	var/squirt_sound = list('modular_septic/sound/gore/artery1.wav', 'modular_septic/sound/gore/artery2.wav', 'modular_septic/sound/gore/artery3.wav')

/obj/item/organ/artery/Insert(mob/living/carbon/new_owner, special = FALSE, drop_if_replaced = TRUE, new_zone = null)
	. = ..()
	new_owner.update_artery_overlays()

/obj/item/organ/artery/Remove(mob/living/carbon/organ_owner, special)
	. = ..()
	organ_owner.update_artery_overlays()

/obj/item/organ/artery/can_heal(delta_time, times_fired)
	return FALSE

/obj/item/organ/artery/on_life(delta_time, times_fired)
	. = ..()
	// Dead, pulseless or cryosleep people do not pump blood
	if(!(is_bruised() || is_failing()) || !owner.pulse || (owner.bodytemperature <= TCRYO))
		return
	var/bleed_mod = 1 * (damage/maxHealth)
	var/obj/item/bodypart/limb = owner.get_bodypart(current_zone)
	if(LAZYLEN(limb.grasped_by))
		bleed_mod *= 0.5
	if(limb.current_gauze)
		bleed_mod *= 0.5
	switch(owner.pulse)
		if(PULSE_NONE)
			bleed_mod *= 0
		if(PULSE_SLOW)
			bleed_mod *= 0.8
		if(PULSE_FAST)
			bleed_mod *= 1.25
		if(PULSE_FASTER, PULSE_THREADY)
			bleed_mod *= 1.5
	if(ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		if(human_owner.physiology)
			bleed_mod *= human_owner.physiology.bleed_mod
	var/final_bleed_rate = CEILING(blood_flow * bleed_mod, 0.1)
	if(!final_bleed_rate)
		return
	if(COOLDOWN_FINISHED(src, next_squirt))
		squirt(final_bleed_rate)
	else
		squirt_less(final_bleed_rate)

/obj/item/organ/artery/applyOrganDamage(amount, maximum = maxHealth, silent = FALSE)
	. = ..()
	owner?.update_artery_overlays()

/obj/item/organ/artery/tear()
	if(!owner)
		return
	if(owner.stat < UNCONSCIOUS)
		owner.death_scream()
	owner.bleed(blood_flow)
	current_blood = 0
	applyOrganDamage(maxHealth * 0.5)
	var/cd_time = rand(squirt_delay_min_seconds, squirt_delay_max_seconds) SECONDS
	COOLDOWN_START(src, next_squirt, cd_time)

/obj/item/organ/artery/dissect()
	if(!owner)
		return
	if(owner.stat < UNCONSCIOUS)
		owner.death_scream()
	owner.bleed(blood_flow)
	current_blood = 0
	applyOrganDamage(maxHealth)
	var/cd_time = rand(squirt_delay_min_seconds, squirt_delay_max_seconds) SECONDS
	COOLDOWN_START(src, next_squirt, cd_time)

/obj/item/organ/artery/mend()
	if(!owner)
		return
	setOrganDamage(0)

/obj/item/organ/artery/proc/squirt(amount = 1, force = FALSE)
	var/obj/item/bodypart/limb = owner.get_bodypart(current_zone)
	var/open_wound = FALSE
	for(var/datum/wound/wound as anything in limb.wounds)
		if(wound.blood_flow)
			open_wound = TRUE
			break
	for(var/datum/injury/injury as anything in limb.injuries)
		if(injury.is_bleeding())
			open_wound = TRUE
			break
	var/unrestricted_flow = TRUE
	if(LAZYLEN(limb.grasped_by) || limb.current_gauze)
		unrestricted_flow = FALSE
	if(unrestricted_flow || force)
		if(open_wound && (owner.get_blood_circulation() >= amount) || force)
			playsound(owner, squirt_sound, 75, 0)
			owner.bleed(amount)
			if(limb.current_gauze)
				limb.seep_gauze(amount * limb.current_gauze.absorption_rate)
			owner.visible_message(span_danger("<b>[owner]</b>'s [limb.name]'s [name] squirts blood!"), \
							span_userdanger("Blood squirts from my [limb.name]'s [name]!"))
			if(CHECK_BITFIELD(owner.mob_biotypes, MOB_ORGANIC|MOB_HUMANOID) && owner.needs_heart() && !(NOBLOOD in owner.dna?.species?.species_traits))
				var/obj/projectile/blood/blood_projectile = new (get_turf(owner), owner.get_blood_dna_list())
				blood_projectile.do_squirt(pick(GLOB.alldirs), rand(1,3), -180, 180)
			COOLDOWN_START(src, next_squirt, rand(squirt_delay_min_seconds, squirt_delay_max_seconds) SECONDS)
		else
			COOLDOWN_START(src, next_squirt, rand(squirt_delay_min_seconds, squirt_delay_max_seconds) SECONDS)
			return squirt_less(amount, open_wound)
	else
		return squirt_less(amount, open_wound)

/obj/item/organ/artery/proc/squirt_less(amount = 1, open_wound = TRUE)
	// Just bleed without being *too* dramatic
	if(open_wound)
		owner.bleed(amount)
		var/obj/item/bodypart/limb = owner.get_bodypart(current_zone)
		if(limb.current_gauze)
			limb.seep_gauze(amount * limb.current_gauze.absorption_rate)
	// No open wound, even less drama
	else
		owner.adjust_bloodvolume(-amount)
