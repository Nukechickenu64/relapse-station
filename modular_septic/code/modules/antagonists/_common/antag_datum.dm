/datum/antagonist
	/// Greeting sound when this antagonist is applied, if any
	var/greeting_sound = 'modular_septic/sound/villain/villain.ogg'
	/// Combat music we give to the owner when applied
	var/combat_music = 'modular_septic/sound/music/combat/stress.ogg'
	/// Attribute sheet we give to the owner
	var/datum/attribute_holder/sheet/attribute_sheet
	/// Set to true if the sheet should be copied, not added
	var/should_copy_attribute_sheet = FALSE

/datum/antagonist/on_gain()
	. = ..()
	if(owner)
		if(combat_music)
			owner.combat_music = pick(combat_music)
		if(ispath(attribute_sheet, /datum/attribute_holder/sheet))
			if(should_copy_attribute_sheet)
				owner.current?.attributes?.copy_sheet(attribute_sheet)
			else
				owner.current?.attributes?.add_sheet(attribute_sheet)

/datum/action/antag_info
	name = "Antagonist Information: "
	action_tab = /datum/peeper_tab/actions/villain

/datum/antagonist/inborn
	combat_music = 'modular_septic/sound/music/combat/deathmatch/inborn.ogg'
	show_to_ghosts = TRUE

/datum/antagonist/inborn/on_gain()
	. = ..()
	if(combat_music)
		owner.combat_music = pick(combat_music)

/datum/antagonist/denominator
	name = "Third Denomination Agent"
	roundend_category = "denominators"
	antagpanel_category = "Denominator"
	var/employer = "OcularTech"
	preview_outfit = /datum/outfit/denominator
	antag_hud_type = ANTAG_HUD_DENOMINATOR
	antag_hud_name = "deno"
	combat_music = 'modular_septic/sound/music/combat/deathmatch/denominator.ogg'
	show_to_ghosts = TRUE

/datum/antagonist/denominator/greet()
	owner.current.playsound_local(get_turf(owner.current), 'modular_septic/sound/greetings/deno_greet.ogg',100,0, use_reverb = FALSE)
	to_chat(owner, span_notice("You are an Agent of the Third Denomination."))
	owner.announce_objectives()

/datum/antagonist/denominator/shotgunner
	name = "Third Denomination Shotgunner"
	preview_outfit = /datum/outfit/denominator/shotgunner
	antag_hud_name = "deno_shotgunner"
	combat_music = 'modular_septic/sound/music/combat/deathmatch/denominator_shotgunner.ogg'

/datum/antagonist/denominator/on_gain(mob/user)
	. = ..()
	ADD_TRAIT(user, TRAIT_DENOMINATOR_ACCESS, SAFEZONE_ACCESS)
	if(combat_music)
		owner.combat_music = pick(combat_music)
	var/datum/component/babble/babble = owner.GetComponent(/datum/component/babble)
	if(!babble)
		owner.AddComponent(/datum/component/babble, 'modular_septic/sound/voice/babble/denom.wav')
	else
		babble.babble_sound_override = 'modular_septic/sound/voice/babble/denom.wav'
		babble.volume = BABBLE_DEFAULT_VOLUME
		babble.duration = BABBLE_DEFAULT_DURATION

/datum/antagonist/denominator/shotgunner/on_gain()
	. = ..()
	ADD_TRAIT(owner, TRAIT_DENOMINATOR_REDSCREEN, MEGALOMANIAC_TRAIT)
