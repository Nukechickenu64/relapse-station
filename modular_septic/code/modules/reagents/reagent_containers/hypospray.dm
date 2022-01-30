/obj/item/reagent_containers/hypospray/medipen/blacktar
	name = "Captagon medipen"
	desc = "Black Tar Heroin."
	icon_state = "stimpen"
	inhand_icon_state = "stimpen"
	base_icon_state = "stimpen"
	volume = 55
	amount_per_transfer_from_this = 55
	list_reagents = list(/datum/reagent/medicine/copium = 10, /datum/reagent/medicine/c2/tirimol = 20, /datum/reagent/medicine/c2/helbital = 25,)

/obj/item/reagent_containers/hypospray/medipen/inject(mob/living/affected_mob, mob/user)
	. = ..()
	if(.)
		reagents.maximum_volume = 0 //Makes them useless afterwards
		reagents.flags = NONE
		playsound(src, 'modular_septic/sound/effects/stimulator.wav', volume, TRUE)
		update_appearance()
