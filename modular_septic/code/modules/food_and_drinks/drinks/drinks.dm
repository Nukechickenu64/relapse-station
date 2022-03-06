/obj/item/reagent_containers/food/drinks/mug/tea/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/tea, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/mug/coco/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/chocolate, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/soda_cans/coca_cola
	name = "Coca Cola"
	desc = "Danger of lethal explosion when shook."
	icon = 'modular_septic/icons/obj/soder.dmi'
	icon_state = "cocaine_cola"
	list_reagents = list(/datum/reagent/consumable/coca_cola = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi
	name = "Pepsi"
	desc = "Worse then Coca Cola."
	icon = 'modular_septic/icons/obj/soder.dmi'
	icon_state = "pepsi"
	list_reagents = list(/datum/reagent/consumable/pepsi = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/coca_cola/diet
	name = "Diet Coca Cola"
	desc = "Replacing the sugar in the original drink with a concentrated essance from the creatura, \"Baphomet\" managing to be only 1% less toxic to your body."
	icon = 'modular_septic/icons/obj/soder.dmi'
	icon_state = "cocaine_cola_diet"
	list_reagents = list(/datum/reagent/consumable/coca_cola/diet = 30)
	foodtype = MEAT

/obj/item/reagent_containers/food/drinks/soda_cans/mug
	name = "Mug Root Beer"
	desc = "DUDE, THAT'S FUCKING HELLA MUG MOMENT DUDE!"
	icon = 'modular_septic/icons/obj/soder.dmi'
	icon_state = "mug"
	list_reagents = list(/datum/reagent/consumable/mug = 30)
	foodtype = SUGAR
