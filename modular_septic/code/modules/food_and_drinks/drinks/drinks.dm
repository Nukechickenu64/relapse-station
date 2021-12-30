/obj/item/reagent_containers/food/drinks/mug/tea/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/tea, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/mug/coco/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/chocolate, 5, 3 MINUTES)
