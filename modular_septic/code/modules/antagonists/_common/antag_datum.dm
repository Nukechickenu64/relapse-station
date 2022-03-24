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
		if(owner.current?.hud_used?.peeper)
			var/datum/peeper/peeper = owner.current.hud_used.peeper
			if(!peeper.peeper_tabs[/datum/peeper_tab/actions/villain])
				peeper.add_peeper_tab(/datum/peeper_tab/actions/villain)

/datum/action/antag_info
	name = "Antagonist Information: "
	action_category = ACTIONS_VILLAIN
