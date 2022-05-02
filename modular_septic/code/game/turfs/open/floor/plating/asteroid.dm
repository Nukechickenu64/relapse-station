/turf/open/floor/plating/asteroid/snow/nevado_surface
	name = "snow"
	desc = "Looks cold."
	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/snow/ice/nevado_surface
	name = "ice"
	desc = "Looks very cold."
	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/snow/river
	name = "icy river"
	desc = "Looks wet and cold."
	icon_state = "snow-ice"
	base_icon_state = "snow-ice"
	plane = OPENSPACE_PLANE
	baseturfs = /turf/open/floor/plating/asteroid/snow
	liquid_height = -(ONE_LIQUIDS_HEIGHT*4)
	turf_height = -TURF_HEIGHT_BLOCK_THRESHOLD
	floor_variance = 0
	var/liquids_are_immutable = FALSE
	var/initial_liquid = /datum/reagent/consumable/ice
	var/initial_liquid_amount = 400
	var/initial_liquid_temperature = T0C-10

/turf/open/floor/plating/asteroid/snow/river/Initialize()
	. = ..()
	if(liquids_are_immutable)
		var/atom/movable/liquid/liquidation = SSliquids.get_immutable(initial_liquid)
		if(liquidation)
			liquidation.add_turf(src)
	else
		if(!liquids && initial_liquid)
			add_liquid(initial_liquid, initial_liquid_amount, FALSE, initial_liquid_temperature)

/turf/open/floor/plating/asteroid/snow/river/baluarte
	initial_liquid = /datum/reagent/water
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	initial_liquid_temperature = T0C

/turf/open/floor/plating/asteroid/snow/river/nevado_surface
	baseturfs = /turf/open/floor/plating/asteroid/snow/nevado_surface
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	initial_liquid = /atom/movable/liquid/immutable/ocean/nevado
	liquids_are_immutable = TRUE

/turf/open/floor/plating/asteroid/snow/river/nevado_surface/acid
	name = "infernal river of dissolution"
	desc = "Ah, an acid bath. Delicious."
	initial_liquid = /datum/reagent/toxin/piranha_solution
	liquids_are_immutable = FALSE

/turf/open/floor/plating/asteroid/nevado_caves
	name = "cave floor"
	baseturfs = /turf/open/floor/plating/asteroid/nevado_caves
	icon = 'modular_septic/icons/turf/floors/coolrock.dmi'
	icon_state = "coolrock"
	base_icon_state = "coolrock"
	floor_variance = 50
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	digResult = /obj/item/stack/ore/glass

/turf/open/floor/plating/asteroid/nevado_caves/Initialize(mapload)
	. = ..()
	if(prob(floor_variance))
		icon_state = "[base_icon_state][rand(0,1)]"
	else
		icon_state = base_icon_state

/turf/open/floor/plating/asteroid/nevado_caves/setup_broken_states()
	return list("coolrock_dug")

/turf/closed/mineral/random/nevado_caves
	name = "cave wall"
	icon = 'modular_septic/icons/turf/mining.dmi'
	smooth_icon = 'modular_septic/icons/turf/walls/redrock.dmi'
	icon_state = "redrock"
	base_icon_state = "redrock"
	environment_type = "redrock"
	turf_type = /turf/open/floor/plating/asteroid/nevado_caves
	baseturfs = /turf/open/floor/plating/asteroid/nevado_caves
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	defer_change = TRUE

	mineralChance = 10
	mineralSpawnChanceList = list( \
		/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 2, /obj/item/stack/ore/gold = 10, \
		/obj/item/stack/ore/titanium = 11, /obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, \
		/obj/item/stack/ore/iron = 50)
