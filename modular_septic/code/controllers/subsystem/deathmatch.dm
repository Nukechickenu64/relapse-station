/**
 * This subsystem is only used in case the deathmatch ruleset is chosen roundstart.
 */
SUBSYSTEM_DEF(deathmatch)
	name = "Deathmatch"
	flags = SS_NO_INIT|SS_NO_FIRE
	var/datum/audio/current_audio_datum
	var/sound/current_sound_datum

/datum/controller/subsytem/deathmatch/Initialize()
	. = ..()
