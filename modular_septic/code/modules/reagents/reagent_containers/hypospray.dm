/obj/item/reagent_containers/hypospray/medipen/blacktar
	name = "Captagon medipen"
	desc = "Black Tar Heroin, make sure not to inject twice until your current painkiller runs out."
	icon_state = "syndipen"
	inhand_icon_state = "tbpen"
	base_icon_state = "syndipen"
	volume = 100
	amount_per_transfer_from_this = 50
	list_reagents = list(/datum/reagent/medicine/copium = 20, /datum/reagent/medicine/c2/tirimol = 40, /datum/reagent/medicine/c2/helbital = 40)

/obj/item/reagent_containers/hypospray/medipen/antibiotic
	name = "Antibiotic medipen"
	desc = "Spaceacillin medipen, used to clear up infections, help with sickness, etc. Contains 4 indevidual uses."
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	volume = 20
	amount_per_transfer_from_this = 5
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 20)


/obj/item/reagent_containers/hypospray/medipen/inject(mob/living/affected_mob, mob/user)
	. = ..()
	if(.)
		reagents.maximum_volume = 0 //Makes them useless afterwards
		reagents.flags = NONE
		playsound(src, 'modular_septic/sound/effects/stimulator.wav', volume, TRUE)
		update_appearance()
