/mob
	/// Skill holder
	var/datum/attribute_holder/attributes
	/// Sound we play to the player who controls us on death
	var/deathsound_local = sound('modular_septic/sound/effects/flatline.ogg', FALSE, 0, CHANNEL_EAR_RING, 100)
	/// Works like client.movement_locked, but handled mob-wise
	var/movement_locked = FALSE
	/// Hydration level of the mob
	var/hydration = HYDRATION_LEVEL_START_MIN // Randomised in Initialize
	/// Hydration satiation level of the mob
	var/hydro_satiety = 0 //Carbon
