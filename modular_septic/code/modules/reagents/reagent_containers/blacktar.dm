#define BLACKTAR_RETRACTED 1
#define BLACKTAR_RETRACTING 2
#define BLACKTAR_EXTENDED 3
#define BLACKTAR_EXTENDING 4

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar
	name = "Captagon medipen"
	desc = "Black Tar Heroin, make sure not to inject twice until your current painkiller runs out."
	icon = 'modular_septic/icons/obj/items/syringe.dmi'
	icon_state = "captagon"
	base_icon_state = "captagon"
	inhand_icon_state = "tbpen"
	volume = 100
	amount_per_transfer_from_this = 50
	possible_transfer_amounts = 50
	stimulator_sound = 'modular_septic/sound/efn/captagon/heroin_injection.ogg'
	var/state = BLACKTAR_RETRACTED
	list_reagents = list(/datum/reagent/medicine/copium = 20, /datum/reagent/medicine/c2/tirimol = 40, /datum/reagent/medicine/c2/helbital = 40)

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/update_overlays()
	. = ..()
	switch(state)
		if(BLACKTAR_EXTENDED)
			. += "[base_icon_state]_needle"
		if(BLACKTAR_EXTENDING)
			. += "[base_icon_state]_needle_out"
		if(BLACKTAR_RETRACTING)
			. += "[base_icon_state]_needle_in"

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/toggle_needle(mob/user)
	if(state == BLACKTAR_EXTENDING || state == BLACKTAR_RETRACTING)
		to_chat(user, span_notice("[fail_msg()]"))
		return
	if(state == BLACKTAR_RETRACTED)
		playsound(src, needle_out_sound, 65, FALSE)
		INVOKE_ASYNC(src, .proc/extend)
	else
		playsound(src, needle_in_sound, 65, FALSE)
		INVOKE_ASYNC(src, .proc/retract)

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/proc/extend()
	state = BLACKTAR_EXTENDING
	update_appearance(UPDATE_ICON)
	sleep(3)
	state = BLACKTAR_EXTENDED
	retracted = FALSE
	update_appearance(UPDATE_ICON)

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/proc/retract()
	state = BLACKTAR_RETRACTING
	update_appearance(UPDATE_ICON)
	sleep(3)
	state = BLACKTAR_RETRACTED
	retracted = TRUE
	update_appearance(UPDATE_ICON)

/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar/update_icon_state()
	. = ..()
	if(reagents.total_volume >= volume)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? 1 : 0]"

#undef BLACKTAR_RETRACTED
#undef BLACKTAR_RETRACTING
#undef BLACKTAR_EXTENDED
#undef BLACKTAR_EXTENDING
