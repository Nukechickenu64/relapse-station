/obj
	/// How good a given object is at causing organ damage on carbons. Higher values equal better shots at creating serious wounds.
	var/organ_bonus = 0
	/// If this attacks a human with no organ armor on the affected body part, add this to the organ mod. Some attacks may be significantly worse at wounding if there's even a slight layer of armor to absorb some of it vs bare flesh
	var/bare_organ_bonus = 0

/obj/on_rammed(mob/living/carbon/rammer)
	rammer.ram_stun()
	var/smash_sound = pick('modular_septic/sound/gore/smash1.ogg',
						'modular_septic/sound/gore/smash2.ogg',
						'modular_septic/sound/gore/smash3.ogg')
	playsound(src, smash_sound, 80)
	rammer.sound_hint()
	sound_hint()
	take_damage(GET_MOB_ATTRIBUTE_VALUE(rammer, STAT_STRENGTH))
