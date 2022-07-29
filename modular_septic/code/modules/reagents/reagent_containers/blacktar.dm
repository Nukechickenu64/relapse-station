/obj/item/reagent_containers/hypospray/medipen/blacktar
	name = "Captagon medipen"
	desc = "Black Tar Heroin, make sure not to inject twice until your current painkiller runs out."
	icon = 'modular_septic/icons/obj/items/syringe.dmi'
	icon_state = "captagon"
	base_icon_state = "captagon"
	inhand_icon_state = "tbpen"
	volume = 100
	amount_per_transfer_from_this = 50
	stimulator_sound = 'modular_septic/sound/efn/captagon/heroin_injection.ogg'
	list_reagents = list(/datum/reagent/medicine/copium = 20, /datum/reagent/medicine/c2/tirimol = 40, /datum/reagent/medicine/c2/helbital = 40)

/obj/item/reagent_containers/hypospray/medipen/blacktar/update_icon_state()
	. = ..()
	if(reagents.total_volume >= volume)
		icon_state = base_icon_state
		return
	icon_state = "[base_icon_state][(reagents.total_volume > 0) ? 1 : 0]"
