/datum/hud
	var/image/shadowcasting_holder
	var/atom/movable/screen/fullscreen/fog_blocker/fog_blocker
	var/atom/movable/screen/fullscreen/noise/noise
	var/atom/movable/screen/fullscreen/pain_flash/pain_flash
	var/atom/movable/screen/fullscreen/static_flash/static_flash
	var/atom/movable/screen/sadness/sadness
	var/atom/movable/screen/fov_holder/fov_holder
	var/atom/movable/screen/stats/stat_viewer
	var/atom/movable/screen/lookup/lookup
	var/atom/movable/screen/lookdown/lookdown
	var/atom/movable/screen/surrender/surrender
	var/atom/movable/screen/pressure/pressure
	var/atom/movable/screen/nutrition/nutrition
	var/atom/movable/screen/hydration/hydration
	var/atom/movable/screen/temperature/temperature
	var/atom/movable/screen/bodytemperature/bodytemperature
	var/atom/movable/screen/fixeye/fixeye
	var/atom/movable/screen/human/pain/pain_guy
	var/atom/movable/screen/breath/breath
	var/atom/movable/screen/fatigue/fatigue
	var/atom/movable/screen/bookmark/bookmark
	var/atom/movable/screen/human/equip
	var/atom/movable/screen/swap_hand/swap_hand
	var/atom/movable/screen/info/info_button
	var/atom/movable/screen/combat_style/combat_style
	var/atom/movable/screen/intent_select/intents
	var/atom/movable/screen/dodge_parry/dodge_parry
	var/atom/movable/screen/special_attack/special_attack
	var/atom/movable/screen/sleeping/sleeping
	var/atom/movable/screen/teach/teach
	var/atom/movable/screen/wield/wield
	var/atom/movable/screen/sprint/sprint
	var/atom/movable/screen/mov_intent/mov_intent
	var/atom/movable/screen/enhanced_sel/enhanced_sel
	var/atom/movable/screen/filler/filler

	var/upper_inventory_shown = FALSE
	var/list/upper_inventory = list()

	var/uses_film_grain = TRUE

/datum/hud/New(mob/owner)
	. = ..()
	if(uses_film_grain && (!owner?.client || owner.client?.prefs?.read_preference(/datum/preference/toggle/filmgrain)))
		noise = new()
		noise.hud = src
		screenoverlays |= noise
		noise.update_appearance()
	sadness = new()
	sadness.hud = src
	screenoverlays |= sadness
	pain_flash = new()
	pain_flash.hud = src
	static_flash = new()
	static_flash.hud = src
	fog_blocker = new()
	fog_blocker.hud = src
	screenoverlays |= pain_flash
	screenoverlays |= static_flash
	screenoverlays |= fog_blocker

/datum/hud/show_hud(version, mob/viewmob)
	. = ..()
	var/mob/screenmob = viewmob || mymob
	if(noise)
		screenmob.client?.screen |= noise
	if(pain_flash)
		screenmob.client?.screen |= pain_flash
	if(static_flash)
		screenmob.client?.screen |= static_flash
	if(sadness)
		screenmob.client?.screen |= sadness
	if(fov_holder)
		screenmob.client?.screen |= fov_holder
	if(fog_blocker)
		screenmob.client?.screen |= fog_blocker
		fog_blocker.update_for_view(screenmob.client.view)

/datum/hud/get_action_buttons_icons()
	. = list()
	.["bg_icon"] = 'modular_septic/icons/hud/quake/actions.dmi'
	.["bg_state"] = "template"

	//TODO : Make these fit theme
	.["toggle_icon"] = 'modular_septic/icons/hud/quake/actions.dmi'
	.["toggle_hide"] = "hide"
	.["toggle_show"] = "show"
